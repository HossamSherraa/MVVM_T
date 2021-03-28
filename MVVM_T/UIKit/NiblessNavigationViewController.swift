//
//  NiblessNavigationViewController.swift
//  Kooper_MVVM
//
//  Created by Hossam on 27/03/2021.
//

import UIKit
class NiblessNavigationViewController : UINavigationController , UINavigationControllerDelegate{
    init() {
        super.init(nibName: nil, bundle: nil)
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
