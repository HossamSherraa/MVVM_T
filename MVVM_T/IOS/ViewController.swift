//
//  ViewController.swift
//  MVVM_T
//
//  Created by Hossam on 28/03/2021.
//

import UIKit

class ViewController: UIViewController {

    override func loadView() {
        let mapView = MapRootView(dropOffLocation: .init(x: 30.033333, y: 30.033333))
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
            mapView.addPickupLocation(at: Location(x: 35.033333, y: 35.033333))
        }
        view = mapView

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

