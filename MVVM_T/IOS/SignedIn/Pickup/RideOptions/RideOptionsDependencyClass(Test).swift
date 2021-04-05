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
            RideOption.init(name: "First Option", id: "grand", imageName: .init(selected: "ride_option_kangaroo_selected", unselected: "ride_option_kangaroo")),
            RideOption.init(name: "second Option", id: "grand2", imageName: .init(selected: "ride_option_kangaroo_selected", unselected: "ride_option_kangaroo")),
            RideOption.init(name: "third Option", id: "grand3", imageName: .init(selected: "ride_option_kangaroo_selected", unselected: "ride_option_kangaroo")),
        ]
            
            .publisher
            .collect()
            .eraseToAnyPublisher()
    }
    
    
}




struct SelectOptionResponderTest : SelectOptionResponder {
    func didSelectRideOption(_ id: RideOptionID) {
        print(id)
    }
    
    
}

class RideOptionsDependencyClass : RideOptionsViewControllerFactory {
    func makeViewModel() -> RideOptionViewModel {
        return .init(rideOptionsRepository: TestRideOptionsRepository(), rideOptionSegmentModel: RideOptionSegmentModel(imageLoader: RideOptionsSigmentImageLoader(imageCache: BundleImageCache())), pickupLocation: .init(latitude: 31.00, longitude: 32.00))
    }
}
