//
//  ViewController.swift
//  MVVM_T
//
//  Created by Hossam on 28/03/2021.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        let rideViews = RequestingRideView()
        rideViews.turnOffAutoresizingMask()
        view.addSubview(rideViews)
        NSLayoutConstraint.activate([
            rideViews.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rideViews.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rideViews.heightAnchor.constraint(equalTo: view.heightAnchor , multiplier: 1 , constant: -80),
            rideViews.widthAnchor.constraint(equalTo: view.widthAnchor , multiplier: 1)
        ])
        
       
        
    }


}

