//
//  RideOptionViewModel.swift
//  MVVM_T
//
//  Created by Hossam on 02/04/2021.
//

import Foundation
import Combine
import UIKit
class RideOptionViewModel: SelectOptionResponder {
    func didSelectRideOption(_ id: RideID) {
        selectedRideID = id
    }
    
    internal init(selectedRideID: RideID? = nil, rideOptionsRepository: RideOptionsRepository, rideOptionSegmentModel: RideOptionSegmentModelLinker, pickupLocation: Location) {
        self.selectedRideID = selectedRideID
        self.rideOptionsRepository = rideOptionsRepository
        self.rideOptionSegmentModel = rideOptionSegmentModel
        self.pickupLocation = pickupLocation
        bindState()
    }
    
   private var selectedRideID : RideID? = nil
    let rideOptionsRepository : RideOptionsRepository
    let rideOptionSegmentModel : RideOptionSegmentModelLinker
    
    var subscribtions : Set<AnyCancellable> = []
    let pickupLocation : Location
    
    
    
    func loadAllRides(){
        rideOptionsRepository.loadAvilableRideOptions(at: pickupLocation)
            .flatMap(\.publisher)
            .map{RideOptionOptionModel(rideOption:$0, selectOptionResponder: self)}
            .collect()
            .assign(to: \.rideOptionOptionModels, on: rideOptionSegmentModel)
            .store(in: &subscribtions)
            
            }
            

    
    
    func bindState(){
        rideOptionSegmentModel
            .$selectedRideID
            .assign(to: \.selectedRideID, on: self)
            .store(in: &subscribtions)
        
    }
    
    
    
    
}

protocol RideOptionsRepository{
    func loadAvilableRideOptions(at pickupLocation : Location)->AnyPublisher<[RideOption] , Never>
}



struct RideOption : Codable{
    let name : String
    let id : RideID
    let imageName : RideOptionImageName
}
typealias RideID = String
struct RideOptionImageName : Codable {
    let selected : String
    let unselected : String
}

class RideOptionSegmentModelLinker {
    @Published var rideOptionOptionModels : [RideOptionOptionModel] = []
    @Published var selectedRideID : RideID? = nil
}

class RideOptionOptionModel {
    enum RideImage {
        case loadedImage(UIImage , UIImage)
        case unloaded(String , String)
    }
    var rideImage : RideImage
    let name : String
    let id : RideID
    let selectOptionResponder : SelectOptionResponder
    
    
    init(rideOption : RideOption , selectOptionResponder : SelectOptionResponder ){
        self.selectOptionResponder = selectOptionResponder
        rideImage = .unloaded(rideOption.imageName.selected, rideOption.imageName.unselected)
        self.name = rideOption.name
        self.id = rideOption.id
    }
    
    
    @objc
    func onSelect(){
        selectOptionResponder.didSelectRideOption(id)
    }
}







protocol SelectOptionResponder {
    func didSelectRideOption(_ id : RideID)
}

class RideOptionSegmentModel : RideOptionSegmentModelLinker,  SelectOptionResponder {
    internal init(imageLoader: SigmentImageLoader) {
        self.imageLoader = imageLoader
        super.init()
        bindValues()
    }
    
    var subscribtions : Set<AnyCancellable> = []
    let imageLoader : SigmentImageLoader
  
    
    func bindValues(){
        $rideOptionOptionModels
            .sink {[weak self] _ in
                guard let self = self else {return}
                self.imageLoader.loadImages(rideOptionOptionModel: &self.rideOptionOptionModels)
            }
            .store(in: &subscribtions)
    }
            
    func didSelectRideOption(_ id: RideID) {
        selectedRideID = id
    }
}




protocol SigmentImageLoader{
    func loadImages(rideOptionOptionModel : inout [RideOptionOptionModel])
}


class RideOptionsSigmentImageLoader : SigmentImageLoader{
    internal init(imageCache: ImageCache) {
        self.imageCache = imageCache
    }
    
    
    let imageCache : ImageCache
    func loadImages(rideOptionOptionModel: inout [RideOptionOptionModel]) {
        rideOptionOptionModel.forEach { model in
            
            guard case .unloaded(let selected, let unselected) = model.rideImage else {return}
           let imagesPublisher = imageCache.loadImages(first: selected, second: unselected)
               let _ = imagesPublisher.sink { images in
                    model.rideImage = .loadedImage(images.0 , images.1)
                }
        }
           
    }
    
    
}

protocol ImageCache {
    func loadImages(first : String ,second : String) -> AnyPublisher<(UIImage , UIImage) , Never>
}


class BundleImageCache : ImageCache{
    func loadImages(first: String, second: String) -> AnyPublisher<(UIImage, UIImage), Never> {
        #warning("Fix Force Wrapper !!! ")
      return  Just((first , second))
            .map{
                return(UIImage(named: $0.0)! , UIImage(named: $0.1)!)
            }
            .eraseToAnyPublisher()
        
    }
    
    
}
