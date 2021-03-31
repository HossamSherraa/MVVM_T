//
//  LocationViewModel.swift
//  MVVM_T
//
//  Created by Hossam on 31/03/2021.
//

import Foundation
import Combine
struct Location {
    let x : Double
    let y : Double
}

protocol Locator{
    func getUserLocation()->AnyPublisher<Location , Never>
}
protocol PickupLocationDeterminedResponder {
    func locationDidDetermined(_ location : Location)
}

class LocationViewModel {
    
    internal init(locator: Locator,
                  pickupLocationDeterminedResponder: PickupLocationDeterminedResponder) {
        self.locator = locator
        self.pickupLocationDeterminedResponder = pickupLocationDeterminedResponder
    }
    
    let locator : Locator
    let pickupLocationDeterminedResponder : PickupLocationDeterminedResponder
    
    var subscribtions : Set<AnyCancellable> = .init()
    
    
    func determineUserLocation(){
        locator.getUserLocation()
            .sink {[weak self] location in
                self?.pickupLocationDeterminedResponder.locationDidDetermined(location)
            }
            .store(in: &subscribtions)
    }
    
    
    
}
