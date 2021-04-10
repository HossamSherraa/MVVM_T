//
//  MapViewController.swift
//  MVVM_T
//
//  Created by Hossam on 04/04/2021.
//

import Foundation
class MapViewController : NiblessViewController {
    let location : Location
    let viewModel : MapViewModel
    override func loadView() {
        view = MapRootView(viewModel: viewModel, dropOffLocation: location)
    }
    init(location : Location , mapViewControllerFactory : MapViewControllerFactory ) {
        self.location = location
        self.viewModel =  mapViewControllerFactory.makeMapViewModel()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol MapViewControllerFactory {
    func makeMapViewModel()->MapViewModel
}
