//
//  SignupViewController.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import UIKit
import Combine
class SignupViewController : NiblessViewController{
    let viewModel : SignupViewModel
    var subscribtions = Set<AnyCancellable>()
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

protocol SignUpViewModelFactory {
    func makeSignupViewModel ()-> SignupViewModel
}
