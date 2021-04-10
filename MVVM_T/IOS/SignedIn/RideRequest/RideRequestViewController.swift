//
//  File.swift
//  MVVM_T
//
//  Created by Hossam on 03/04/2021.
//

import UIKit
class RideRequestViewController : NiblessViewController {
    let viewModel : RideRequestViewModel
    init(rideRequestViewControllerFactory : RideRequestViewControllerFactory , rideRequest : RideRequest) {
        viewModel = rideRequestViewControllerFactory.makeRideRequestViewModel(rideRequest : rideRequest)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = RideRequestRootView(viewModel: viewModel)
    }
    
}

protocol RideRequestViewControllerFactory {
    func makeRideRequestViewModel(rideRequest : RideRequest)->RideRequestViewModel
}
