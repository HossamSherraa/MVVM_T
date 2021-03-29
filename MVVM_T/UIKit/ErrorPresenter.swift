//
//  ErrorPresenter.swift
//  MVVM_T
//
//  Created by Hossam on 29/03/2021.
//

import UIKit
extension UIViewController {
    func presentMessage(title : String , subtitle : String ){
        let action = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        action.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            action.dismiss(animated: true , completion: nil)
        }))
        self.present(action, animated: true, completion: nil)
    }
}
