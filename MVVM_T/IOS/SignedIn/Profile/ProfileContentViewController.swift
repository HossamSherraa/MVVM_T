//
//  ProfileViewController.swift
//  MVVM_T
//
//  Created by Hossam on 30/03/2021.
//

import UIKit
class ProfileContentViewController : UIViewController {
    let viewModel : ProfileViewModel
    override func loadView() {
        view = ProfileRootView(viewModel:viewModel)
    }
    
    init(profileViewControllerFactory : ProfileViewControllerFactory) {
       viewModel =  profileViewControllerFactory.makeProfileViewModel()
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: viewModel, action: #selector(viewModel.onPressDismiss))
        navigationItem.setRightBarButton(leftItem, animated: true)
        
    }
}

protocol ProfileViewControllerFactory{
    func makeProfileViewModel()->ProfileViewModel
}
