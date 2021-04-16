//
//  SignedInViewController.swift
//  MVVM_T
//
//  Created by Hossam on 30/03/2021.
//

import UIKit
import Combine
class SignedInViewController : NiblessViewController {
    private let viewModel : SignedInViewModel
    private let profileViewController : ProfileViewController
    private let locationGetterViewController : LocationGetterViewController
    private let makePickupViewController : (Location)-> PickupViewController
    private let makeRideRequestViewController : (RideRequest)->RideRequestViewController
    
    private var subscribtions : Set<AnyCancellable> = []
    
    
    private lazy var  signedInRootView = SignedInRootView(viewModel: viewModel)
    
    
    init(signedInViewControllerFactory : SignedInViewControllerFactory) {

        self.profileViewController = signedInViewControllerFactory.makeProfileViewController()
        self.locationGetterViewController = signedInViewControllerFactory.makeLocationGetterViewController()
        self.viewModel = signedInViewControllerFactory.makeSignedInViewModel()
        self.makePickupViewController = signedInViewControllerFactory.makePickupViewController(_:)
        self.makeRideRequestViewController = signedInViewControllerFactory.makeRideRequestViewController(_:)
        super.init()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configRootView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindToState()
    }
    
  private func bindToState(){
    viewModel.$view
       
      
        .sink { [weak self] signedInView in
            self?.present(view: signedInView)
        }
        .store(in: &subscribtions)
    }
    
    
   private func present(view : SignedInView ) {
        switch  view {
        case .locationGetter: presentLocationGetter()
        case .pickup(let location ) : presentPickupViewController(at: location)
        case .profile : presentProfile()
        case .waitForPickup(let request) : presentWaitForPickupViewController(with: request)
        }
    }
    
    func presentLocationGetter(){
        
        presentedViewController?.dismiss(animated: true , completion: nil)
        self.addChild(viewController: locationGetterViewController, belowView: signedInRootView)
        
    }
    
    
    func presentWaitForPickupViewController(with request : RideRequest){
        self.dismiss(animated: true , completion: nil)
        let viewController = makeRideRequestViewController(request)
       
    
        present(viewController, animated: true , completion: nil)
    }
    func presentPickupViewController(at location : Location){
        let pickupViewController = makePickupViewController(location)
        removeAllChilds()
        addChild(viewController: pickupViewController, belowView: signedInRootView)
      
       
        
    }
    func presentProfile(){
        self.present(profileViewController, animated: true , completion: nil)
    }
    private func configRootView(){
        signedInRootView.turnOffAutoresizingMask()
        self.view.addSubview(signedInRootView)
        NSLayoutConstraint.activate([
            signedInRootView.widthAnchor.constraint(equalToConstant: 40),
            signedInRootView.heightAnchor.constraint(equalToConstant: 40),
            self.view.trailingAnchor.constraint(equalTo: signedInRootView.trailingAnchor , constant: 10),
            signedInRootView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
}

protocol SignedInViewControllerFactory {
    func makeProfileViewController ()->ProfileViewController
    func makeLocationGetterViewController ()->LocationGetterViewController
    func makeSignedInViewModel()->SignedInViewModel
    func makePickupViewController(_ location : Location) -> PickupViewController
    func makeRideRequestViewController (_ rideRequest : RideRequest)->RideRequestViewController
}



class SignedInViewModel :   PickupLocationDeterminedResponder   , PickupRequestResponder , DismissProfileResponder  , NewRideResponder  {
    func createNewRide() {
        view = .locationGetter
    }
    
   
    @Published var view : SignedInView = .locationGetter 
    
    
    @objc
    func dismissProfile() {
        view = .locationGetter
    }
    
    @objc
    func onPressProfile(){
        view = .profile
    }
    
    func locationDidDetermined(_ location: Location) {
        view = .pickup(location)
    }
    
    func didRecievedRequest(_ rideRequest: RideRequest) {
        
        print(rideRequest)
        view = .waitForPickup(rideRequest)
    }
    
    
}


enum SignedInView {
    case profile
    case locationGetter
    case pickup(Location)
    case waitForPickup(RideRequest)
    static var `default` : SignedInView  = .locationGetter
}
