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
    let location : Location
    
    var subscribtions : Set<AnyCancellable> = []
    lazy var pickupRootView : PickupRootView = PickupRootView(viewModel: pickupViewModel)
    override func loadView() {
        self.view = pickupRootView
    }
    init(pickViewControllerFactory : PickupViewControllerFactory , location : Location) {
        self.mapViewController = pickViewControllerFactory.makeMapViewController()
        self.pickupLocationPicker = pickViewControllerFactory.makePickupLocationPicker
        self.rideOptionsViewController = pickViewControllerFactory.rideOptionsViewController
        self.pickupViewModel = pickViewControllerFactory.makePickupViewModel()
        self.location = location
        super.init()
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
       
        mapViewController.view.frame = UIScreen.main.bounds
        self.view.insertSubview(mapViewController.view, at: 0)
    }
    func presentPickupLocationPicker(){
        let pickupLocationPicker = self.pickupLocationPicker()
        self.present(pickupLocationPicker, animated: true)
    }
    
    func presentRideOptions(){
        self.presentedViewController?.dismiss(animated: true , completion: {
            
            let rideOptionsViewController = self.rideOptionsViewController()
            self.present(rideOptionsViewController, animated: true , completion: nil)
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        responseToViewChange()
    }
    

    
}

protocol PickupViewControllerFactory {
    func makeMapViewController()->MapViewController
    func makePickupLocationPicker ()->PickupLocationPickerViewController
    func rideOptionsViewController ()->RideOptionsViewController
    func makePickupViewModel()->PickupViewModel
}


extension UIViewController {
    func addChild( viewController : UIViewController ,  belowView : UIView){
        self.addChild(viewController)
        if let viewControllerview = viewController.view{
            viewControllerview.frame = self.view.bounds
            self.view.insertSubview(viewControllerview, belowSubview: belowView)
        }
    }
    
    func removeChild(viewController : UIViewController){
        if let viewControllerView = viewController.view {
            viewControllerView.removeFromSuperview()
        }
    }
    
    func removeAllChildsViewControllers(){
        children.forEach(removeChild(viewController:))
    }
    
    
}
