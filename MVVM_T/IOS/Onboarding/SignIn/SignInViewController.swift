//
//  SignInViewController.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import UIKit
import Combine
class SigninViewController : NiblessViewController{
    let viewModel : SigninViewModel
    var subscribtions = Set<AnyCancellable>()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindErrors(publisher: viewModel.errorPublisher)
    }
    
    func bindErrors(publisher : PassthroughSubject<String , Never>){
        publisher.sink { [weak self] (message) in
            self?.presentMessage(title: "Error", subtitle: message)
        }
        .store(in: &subscribtions)
    }
}

protocol SigninViewModelFactory {
    func makeSigninViewModel ()-> SigninViewModel
}
