//
//  SignInViewController.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import UIKit

class SigninViewController : NiblessViewController{
    let viewModel : SigninViewModel
    
    init(signinViewModelFactory : SigninViewModelFactory) {
        viewModel =  signinViewModelFactory.makeSigninViewModel()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        self.view = SignInRootView(viewModel: viewModel)
    }
}

protocol SigninViewModelFactory {
    func makeSigninViewModel ()-> SigninViewModel
}
