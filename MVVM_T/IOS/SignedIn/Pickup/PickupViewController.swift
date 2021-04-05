//
//  PickupViewController.swift
//  MVVM_T
//
//  Created by Hossam on 01/04/2021.
//

import UIKit
import Combine

class PickupViewController : NiblessViewController {
    let pickupViewModel : PickupViewModel
    let mapViewController : MapViewController
    let pickupLocationPicker : ()->PickupLocationPickerViewController
    let rideOptionsViewController : ()->RideOptionsViewController
    
    var subscribtions : Set<AnyCancellable> = []
    override func loadView() {
        self.view = PickupRootView()
    }
    init(pickViewControllerFactory : PickupViewControllerFactory) {
        self.mapViewController = pickViewControllerFactory.makeMapViewController()
        self.pickupLocationPicker = pickViewControllerFactory.makePickupLocationPicker
        self.rideOptionsViewController = pickViewControllerFactory.rideOptionsViewController
        self.pickupViewModel = pickViewControllerFactory.makePickupViewModel()
        super.init()
    }
    
    
    func buildViewHeirarchy(){
        addChild(viewController: mapViewController, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func responseToViewChange(){
        pickupViewModel.$pickupViewProgress.sink {[weak self] viewProgress in
            guard let self = self else {return}
            switch viewProgress {
            case .map : self.presentMapViewController()
            case .pickupLocationPicker(_) :
                self.presentPickupLocationPicker()
            case .selectOption( _ ):
                self.presentRideOptions()
            
            }
        }
        .store(in: &subscribtions)
    }
    
    func presentMapViewController(){
        removeAllChilds()
        self.addChild(viewController: mapViewController , at: 0)
    }
    func presentPickupLocationPicker(){
        let pickupLocationPicker = self.pickupLocationPicker()
        self.present(pickupLocationPicker, animated: true)
    }
    
    func presentRideOptions(){
        let rideOptionsViewController = self.rideOptionsViewController()
        rideOptionsViewController.willMove(toParent: self)
        guard let rideOptionsView = rideOptionsViewController.view else {return}
        self.addChild(rideOptionsViewController)
        self.view.addSubview(rideOptionsView)
        //ConfigFrameHeight
        rideOptionsView.frame = self.view.bounds
        rideOptionsView.frame.origin.y += view.bounds.height * 0.6 //40% of currentview
        rideOptionsView.frame.size.height = view.bounds.height * 0.6
        
        rideOptionsViewController.didMove(toParent: self)
        
    }
    
    

    
}

protocol PickupViewControllerFactory {
    func makeMapViewController()->MapViewController
    func makePickupLocationPicker ()->PickupLocationPickerViewController
    func rideOptionsViewController ()->RideOptionsViewController
    func makePickupViewModel()->PickupViewModel
}


extension UIViewController {
    func addChild( viewController : UIViewController , at index : Int){
        self.addChild(viewController)
        if let viewControllerview = viewController.view{
            self.view.insertSubview(viewControllerview, at: 0)
            viewControllerview.frame = self.view.bounds
        }
    }
    
    func removeChild(viewController : UIViewController){
        if let viewControllerView = viewController.view {
            viewControllerView.removeFromSuperview()
        }
    }
    
    
}
