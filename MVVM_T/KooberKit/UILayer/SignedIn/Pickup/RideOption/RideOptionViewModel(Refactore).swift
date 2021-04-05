//
//  RideOptionViewModel.swift
//  MVVM_T
//
//  Created by Hossam on 02/04/2021.
//

import Foundation
import Combine
import UIKit
class RideOptionViewModel {
    
    
    internal init(selectedRideID: RideOptionID? = nil, rideOptionsRepository: RideOptionsRepository, rideOptionSegmentModel: RideOptionSegmentModel, pickupLocation: Location) {
        self.selectedRideID = selectedRideID
        self.rideOptionsRepository = rideOptionsRepository
        self.rideOptionSegmentModel = rideOptionSegmentModel
        self.pickupLocation = pickupLocation
        bindSegmentState()
    }
    
    private var selectedRideID : RideOptionID? = nil {
        didSet{//Test
            print(selectedRideID)
        }
    }
    let rideOptionsRepository : RideOptionsRepository
    let rideOptionSegmentModel : RideOptionSegmentModel
    
    var subscribtions : Set<AnyCancellable> = []
    let pickupLocation : Location
    
    
    
    func loadAllRides(){
        rideOptionsRepository.loadAvilableRideOptions(at: pickupLocation)
            .map{
                return $0.map { RideOptionOptionModel(rideOption:$0, selectOptionResponder: self.rideOptionSegmentModel)} }
            .assign(to: \.rideOptionOptionModels, on: rideOptionSegmentModel)
            .store(in: &subscribtions)
            
            }
            

    
    
    func bindSegmentState(){ // Subscribe To Segment For selection to be set to the SelectRideID value
        rideOptionSegmentModel
            .$selectedRideID
            .assign(to: \.selectedRideID, on: self)
            .store(in: &subscribtions)
        
    }
    
    @objc func onConfirm(){ // For Confirm Button
        
    }
    
    
    
}

protocol RideOptionsRepository{
    func loadAvilableRideOptions(at pickupLocation : Location)->AnyPublisher<[RideOption] , Never>
}



struct RideOption : Codable{
    let name : String
    let id : RideOptionID
    let imageName : RideOptionImageName
}
typealias RideOptionID = String
struct RideOptionImageName : Codable {
    let selected : String
    let unselected : String
}


class RideOptionOptionModel {
    enum RideImage {
        case loadedImage(UIImage , UIImage)
        case unloaded(String , String)
        
        var getSelected : UIImage? {
          guard case .loadedImage(let selected, _) = self else {return nil}
                return selected
            }
        
        var getUnselected : UIImage? {
            guard case .loadedImage(_, let unSelected) = self else {return nil}
                  return unSelected
              
        }
        
    }
    var rideImage : RideImage
    let name : String
    let id : RideOptionID
    @Published var isSelected = false 
    let selectOptionResponder : SelectOptionResponder
    
    
    init(rideOption : RideOption , selectOptionResponder : SelectOptionResponder ){
        self.selectOptionResponder = selectOptionResponder
        rideImage = .unloaded(rideOption.imageName.selected, rideOption.imageName.unselected)
        self.name = rideOption.name
        self.id = rideOption.id
    }
    
    
    @objc
    func onSelect(){
        isSelected.toggle()
        selectOptionResponder.didSelectRideOption(id)
    }
}







protocol SelectOptionResponder {
    func didSelectRideOption(_ id : RideOptionID)
}

class RideOptionSegmentModel :   SelectOptionResponder {
    @Published var rideOptionOptionModels : [RideOptionOptionModel] = [] //ViewSubsctibe To Build new Options
    @Published var selectedRideID : RideOptionID? = nil // Whene Selected it will call didSelectRideOption and then set this value , the RideOptionsViewModel subscribe to it
    @Published var viewRideOptionOptionModel : [RideOptionOptionModel] = []
    internal init(imageLoader: SigmentImageLoader) {
        self.imageLoader = imageLoader
        bindValues()
    }
    
    var subscribtions : Set<AnyCancellable> = []
    let imageLoader : SigmentImageLoader
  
    
    func bindValues(){
        $rideOptionOptionModels
            .flatMap(imageLoader.loadImages(rideOptionOptionModel:))
            .assign(to: &$viewRideOptionOptionModel)
        
           
    }
            
    func didSelectRideOption(_ id: RideOptionID) {
        selectedRideID = id
        
        deSelectOtherModels()
    }
    
    func deSelectOtherModels(){
        rideOptionOptionModels.filter({$0.id != selectedRideID}).forEach({$0.isSelected = false})
    }
}




protocol SigmentImageLoader{
    func loadImages(rideOptionOptionModel :  [RideOptionOptionModel])->AnyPublisher<[RideOptionOptionModel],Never>
}


class RideOptionsSigmentImageLoader : SigmentImageLoader{
    internal init(imageCache: ImageCache) {
        self.imageCache = imageCache
    }
    
    
    let imageCache : ImageCache
    func loadImages(rideOptionOptionModel:  [RideOptionOptionModel])->AnyPublisher<[RideOptionOptionModel],Never> {
        
        rideOptionOptionModel.publisher
            .map { model  in
                if case .unloaded(let selected, let unselected) = model.rideImage {
                imageCache.loadImages(first: selected, second: unselected)
                    .sink { selectedImage , unselectedImage in
                        model.rideImage = .loadedImage(selectedImage, unselectedImage)
                    }
                    .cancel()
                    
                }
                return model
            }
            .collect()
            .eraseToAnyPublisher()
           
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
