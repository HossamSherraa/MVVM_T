//
//  MainViewController.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import UIKit
import Combine
class MainViewController : NiblessViewController{
    let onBoardingViewController : ()->OnboardingViewController
    let signedInViewController : (UserSession)->SignedInViewController
    let launchViewController : LaunchViewController
    
    let viewModel : MainViewModel
    
    var subscriptions : Set<AnyCancellable> = []
    
    internal init(factory : MainViewControllerFactory) {
        self.onBoardingViewController = factory.makeOnBoardingViewController
        self.signedInViewController = factory.makeSignedInViewController
        self.launchViewController = factory.makeLaunchViewController()
        self.viewModel = factory.makeMainViewControllerViewModel()
        super.init()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bindToViewState()
    }
    
    func bindToViewState(){
        viewModel.$view
            .sink{ [weak self] view in
                switch view {
                case .launch : self?.presentLaunchViewController() //Present Launch
                case .onBoarding : self?.presentOnBoardingViewController() // Present Onboarding
                case .signedIn(let userSession) : self?.presentSingedInViewController(userSession) // Present SignedIN
                }
                
            }
            .store(in: &subscriptions)
    }
    
    
    func presentLaunchViewController(){
        presentFullScreenViewController(launchViewController)
    }
    
    func presentOnBoardingViewController(){
        let onBoardingViewController = self.onBoardingViewController()
        presentFullScreenViewController(onBoardingViewController)
    
    }
    
    func presentSingedInViewController(_ userSession : UserSession){
        let signedInViewController = self.signedInViewController(userSession)
        presentFullScreenViewController(signedInViewController)
    }
    
    
    
    
    
}

protocol MainViewControllerFactory {
    func makeOnBoardingViewController()->OnboardingViewController
    func makeSignedInViewController(_ userSession : UserSession)->SignedInViewController
    func makeLaunchViewController()->LaunchViewController
    func makeMainViewControllerViewModel()->MainViewModel
}


