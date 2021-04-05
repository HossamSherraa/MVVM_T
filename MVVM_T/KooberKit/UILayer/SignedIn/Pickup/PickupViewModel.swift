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
class PickupViewModel : ConfirmRideOptionResponder , PickupLocationDeterminedResponder {
    internal init(location: Location, requestRideRepository: RequestRideRepository, requestRideResponder: RequestRideResponder) {
        self.location = location
        self.requestRideRepository = requestRideRepository
        self.requestRideResponder = requestRideResponder
    }
    
    
    let location : Location
    let pickupLocation : Location? = nil
    
    var subscribtions : Set<AnyCancellable> = []
    let requestRideRepository : RequestRideRepository
    
    let requestRideResponder : RequestRideResponder
    
    @Published var pickupViewProgress : PickupViewProgress = .map
    
    
    
    func confirmedRideOption(_ rideOptionID: RideOptionID) {
        guard let pickupLocation = pickupLocation else {return}
        requestRideRepository.createRideRequest(dropOffLocation: location, pickupLocation: pickupLocation, rideOptionID: rideOptionID)
            .sink(receiveValue: requestRideResponder.requestNewRide(_:))
            .store(in: &subscribtions)
        
    }
    
    
    func locationDidDetermined(_ location: Location) {
        pickupViewProgress = .selectOption(location)
    }
    
    
    
    @objc
    func onPressWhereToGo(){
        pickupViewProgress = .pickupLocationPicker(location)
    }
    
    
}





protocol RequestRideResponder {
    func requestNewRide(_ ride : RideRequest) // PassedTo NEXT Wait for pickup Responder
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
