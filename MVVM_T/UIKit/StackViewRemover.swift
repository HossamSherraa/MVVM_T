//
//  StackViewRemover.swift
//  MVVM_T
//
//  Created by Hossam on 03/04/2021.
//

import UIKit
extension UIStackView {
    func removeAllArrangedViews(){
        self.arrangedSubviews.forEach{
            self.removeArrangedSubview($0)
        }
    }
}
