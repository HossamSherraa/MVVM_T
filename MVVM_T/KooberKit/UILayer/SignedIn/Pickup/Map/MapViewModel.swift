//
//  MapViewModel.swift
//  MVVM_T
//
//  Created by Hossam on 31/03/2021.
//

import Combine
protocol MapPickupLocationDeterminedResponder{
    func updatePickupLocation (location : Location)
    func updateDropOffLocation(location : Location)
}
class MapViewModel : MapPickupLocationDeterminedResponder {
    func updateDropOffLocation(location: Location) {
        self.dropOffLocation = location
    }
    
    func updatePickupLocation(location: Location) {
        self.pickuplocation = location
    }
    
    
    init(location : Location) {
        dropOffLocation = location
    }
    @Published var dropOffLocation : Location
    @Published var pickuplocation : Location? = nil
    
}
