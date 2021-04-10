//
//  UIGetLocationViewController.swift
//  MVVM_T
//
//  Created by Hossam on 31/03/2021.
//

import UIKit
class LocationGetterViewController : NiblessViewController {
    let viewModel : LocationViewModel
    init(locationGetterFactory : LocationGetterFactory ) {
        viewModel = locationGetterFactory.makeLocationGetterViewModel()
        super.init()
    }
    override func loadView() {
        view = LocationGetterRootView(viewModel: viewModel)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol LocationGetterFactory {
    func makeLocationGetterViewModel()->LocationViewModel
}
