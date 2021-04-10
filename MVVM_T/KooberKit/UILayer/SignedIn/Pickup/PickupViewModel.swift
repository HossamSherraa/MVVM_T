//
//  PickupViewModel.swift
//  MVVM_T
//
//  Created by Hossam on 04/04/2021.
//

import Foundation
import Combine
enum PickupViewProgress {
    case map
    case pickupLocationPicker(Location)
    case selectOption(Location)
}
class PickupViewModel : ConfirmRideOptionResponder   , PickupLocationPickerDeterminedResponder , PickupLocationPickerDismissedResponder  {
    
    
    func pickupLocationPickerDismissed() {
        pickupViewProgress = .map
    }
    func pickupLocationPickerDetermined(_ location: Location) {
        self.pickupLocation = location
        pickupViewProgress = .selectOption(location)
    }
    
    internal init(location: Location, requestRideRepository: RequestRideRepository, requestRideResponder: PickupRequestResponder) {
        self.location = location
        self.requestRideRepository = requestRideRepository
        self.requestRideResponder = requestRideResponder
    }
    
    
    let location : Location
    var pickupLocation : Location? = nil
    
    var subscribtions : Set<AnyCancellable> = []
    let requestRideRepository : RequestRideRepository
    
    let requestRideResponder : PickupRequestResponder
    
    @Published var pickupViewProgress : PickupViewProgress = .map
    
    
    
    func confirmedRideOption(_ rideOptionID: RideOptionID) {
        
        guard let pickupLocation = pickupLocation else {return}
        requestRideRepository.createRideRequest(dropOffLocation: location, pickupLocation: pickupLocation, rideOptionID: rideOptionID)
            .sink(receiveValue: requestRideResponder.didRecievedRequest(_:))
            .store(in: &subscribtions)
        
    }
    
    
    
    
    
    
    
    @objc
    func onPressWhereToGo(){
        pickupViewProgress = .pickupLocationPicker(location)
    }
    
    
}







protocol ConfirmRideOptionResponder {
    func confirmedRideOption(_ rideOptionID : RideOptionID ) //Used To Create Request
}

protocol GoToPickupLocationPickerNavigator{
    func goToLocationPicker(dropOffLocation : Location) //Used To Passed To Picker Location
}

struct RideRequest {
    let pickupLocation : Location
    let dropOffLocation : Location
    let rideOption : RideOptionID
}


protocol RequestRideRepository {
    func createRideRequest(dropOffLocation : Location , pickupLocation : Location , rideOptionID : RideOptionID)->AnyPublisher<RideRequest , Never>
}
