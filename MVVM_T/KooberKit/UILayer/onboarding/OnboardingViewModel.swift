//
//  OnboardingViewModel.swift
//  Kooper_MVVM
//
//  Created by Hossam on 27/03/2021.
//

import Foundation
import Combine

class OnboardingViewModel  : SigninNavigator , SignupNavigator , SignedInResponder , DismissProfileResponder , SignoutResponder  {
    func dismissProfile() {
            
    }
    
    func signedout() {
        
    }
    
    func signedIn(userSession  : UserSession) {
        
    }
    
    
    @Published var view : OnboardingView = .none
    
    func navigateToSignIn() {
        view = .signin
        
    }
    
    func navigateToSignup() {
        view = .signup
    }
    
 
}
