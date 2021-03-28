//
//  OnboardingViewController.swift
//  Kooper_MVVM
//
//  Created by Hossam on 27/03/2021.
//

import UIKit
import Combine
class OnboardingViewController : UINavigationController {
    let viewModel : OnboardingViewModel
    
    let signInViewController : SigninViewController
    let signupViewController : SignupViewController
    let welcomeViewController : WelcomeViewController
    
    var subscribtions = Set<AnyCancellable>()
    
   
   
    init(onboardingFactory  : OnboardingFactory , viewModel : OnboardingViewModel) {
        self.signInViewController = onboardingFactory.makeSignInViewController()
        self.signupViewController = onboardingFactory.makeSignupViewController()
        self.welcomeViewController = onboardingFactory.makeWelcomeViewController()
        self.viewModel = viewModel
        super.init(rootViewController: welcomeViewController)
        
       
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe(viewModel.$view)
    }
    
    
    
    func subscribe(_ publisher : Published<OnboardingView>.Publisher){
        publisher
            
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (com) in
            }, receiveValue:{ [weak self] onboardingView in
                    
                self?.present(onboardingView)
            })
            
        .store(in: &subscribtions)
    }
    
    
    func present(_ view : OnboardingView){
        switch view {
        case .signin: presentSigninViewController()
        case .signup: presentSignupViewController()
        case .welcome: presentWelcomeViewController()
        default:break
        }
    }
    
    func presentSignupViewController(){
        pushViewController(signupViewController, animated: true)
    }
    
    func presentSigninViewController(){
        pushViewController(signInViewController, animated: true)
    }
    
    func presentWelcomeViewController(){
       
        pushViewController(welcomeViewController, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

protocol OnboardingFactory {
    func makeSignInViewController()->SigninViewController
    func makeWelcomeViewController()->WelcomeViewController
    func makeSignupViewController()->SignupViewController
}
