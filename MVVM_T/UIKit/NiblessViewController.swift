//
//  NiblessViewController.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import UIKit
class NiblessViewController : UIViewController{
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIViewController {
    func removeAllChilds(){
        let childs = self.children
        childs.forEach(removeChild(viewController:))
    }
}
