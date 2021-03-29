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
        self.delegate = self
       
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe(viewModel.$view)
        setNavigationBarHidden(true , animated: false )
        configNavigationBarStyle()
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
        setNavigationBarHidden(false , animated: false )
        pushViewController(signInViewController, animated: true)
    }
    
    func presentWelcomeViewController(){
       setNavigationBarHidden(true, animated: false )
        pushViewController(welcomeViewController, animated: false)
    }
    

    
    func configNavigationBarApperance(view : OnboardingView){
        switch view {
        case .signin:  setNavigationBarHidden(false , animated: false  )
        case .signup:  setNavigationBarHidden(false , animated: false  )
        case .welcome:  setNavigationBarHidden(true , animated: false  )
        default: break
        }
    }
    
    func configNavigationBarStyle(){
        navigationBar.barTintColor = UIColor.clear
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = UIColor.white
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension OnboardingViewController : UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        switch  viewController {
        case is SignupViewController: configNavigationBarApperance(view: .signup)
        case is SigninViewController: configNavigationBarApperance(view: .signin)
        case is WelcomeViewController: configNavigationBarApperance(view: .welcome)
        default: break
        }
    }
}


protocol OnboardingFactory {
    func makeSignInViewController()->SigninViewController
    func makeWelcomeViewController()->WelcomeViewController
    func makeSignupViewController()->SignupViewController
}
