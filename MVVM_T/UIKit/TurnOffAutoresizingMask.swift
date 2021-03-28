//
//  TurnOffAutoresizingMask.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import UIKit
extension UIView {
    func turnOffAutoresizingMask(){
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
