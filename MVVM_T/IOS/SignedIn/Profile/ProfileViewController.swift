//
//  ProfileViewController.swift
//  MVVM_T
//
//  Created by Hossam on 31/03/2021.
//

import Foundation
class ProfileViewController : NiblessNavigationViewController{
    
    init(profileViewControllerFactory : ProfileViewControllerFactory) {
        super.init(rootViewController: ProfileContentViewController(profileViewControllerFactory: profileViewControllerFactory))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
