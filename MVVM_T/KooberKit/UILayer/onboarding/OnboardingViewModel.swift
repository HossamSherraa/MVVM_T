//
//  OnboardingViewModel.swift
//  Kooper_MVVM
//
//  Created by Hossam on 27/03/2021.
//

import Foundation
import Combine

class OnboardingViewModel  : SigninNavigator , SignupNavigator , SignedInResponder  {
    func signedIn() {
        
    }
    
    
    @Published var view : OnboardingView = .none
    
    func navigateToSignIn() {
        view = .signin
        
    }
    
    func navigateToSignup() {
        view = .signup
    }
    
 
}