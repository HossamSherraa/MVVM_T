//
//  LaunchViewModel.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import Foundation
class WelcomeViewModel {
    let signinResponder : SigninNavigator
    let signupResponder : SignupNavigator
    init(signinResponder : SigninNavigator , signupResponder : SignupNavigator) {
        self.signinResponder = signinResponder
        self.signupResponder = signupResponder
    }
    
    @objc
    func onSignup(){
        signupResponder.navigateToSignup()
    }
    
    @objc
    func onSignin(){
        signinResponder.navigateToSignIn()
    }
}
