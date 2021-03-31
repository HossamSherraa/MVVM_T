//
//  LaunchViewController.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import UIKit
class WelcomeViewController : NiblessViewController {
    let viewModel : WelcomeViewModel
    override func loadView() {
        self.view = WelcomeRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    init(welcomeViewModelFactory : WelcomeViewModelFactory) {
        viewModel = welcomeViewModelFactory.makeWelcomeViewModel()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

protocol WelcomeViewModelFactory {
    func makeWelcomeViewModel()->WelcomeViewModel
}
