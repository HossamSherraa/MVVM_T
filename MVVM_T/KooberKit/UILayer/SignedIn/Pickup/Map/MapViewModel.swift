//
//  MapViewModel.swift
//  MVVM_T
//
//  Created by Hossam on 31/03/2021.
//

import Combine
class MapViewModel {
    
    init(location : Location) {
        dropOffLocation = location
    }
    @Published var dropOffLocation : Location
    @Published var pickOfflocation : Location? = nil
}
