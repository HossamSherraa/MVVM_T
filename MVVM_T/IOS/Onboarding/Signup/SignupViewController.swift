//
//  SignupViewController.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import UIKit
class SignupViewController : NiblessViewController{
    let viewModel : SignupViewModel
    
    init(signinViewModelFactory : SignUpViewModelFactory) {
        viewModel =  signinViewModelFactory.makeSignupViewModel()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        self.view = SignupRootView(viewModel: viewModel)
    }
}

protocol SignUpViewModelFactory {
    func makeSignupViewModel ()-> SignupViewModel
}
