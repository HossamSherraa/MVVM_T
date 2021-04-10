//
//  RideOptionsDependencyClass.swift
//  MVVM_T
//
//  Created by Hossam on 04/04/2021.
//

import Foundation
import Combine
struct TestRideOptionsRepository : RideOptionsRepository {
    func loadAvilableRideOptions(at pickupLocation: Location) -> AnyPublisher<[RideOption], Never> {
        [
            RideOption.init(name: "First", id: "grand", imageName: .init(selected: "ride_option_kangaroo_selected", unselected: "ride_option_kangaroo")),
            RideOption.init(name: "Second", id: "grand2", imageName: .init(selected: "ride_option_kangaroo_selected", unselected: "ride_option_kangaroo")),
            RideOption.init(name: "Third", id: "grand3", imageName: .init(selected: "ride_option_kangaroo_selected", unselected: "ride_option_kangaroo")),
        ]
            
            .publisher
            .collect()
            .eraseToAnyPublisher()
    }
    
    
}


