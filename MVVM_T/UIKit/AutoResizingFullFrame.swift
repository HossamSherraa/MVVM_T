//
//  AutoResizingFullFrame.swift
//  MVVM_T
//
//  Created by Hossam on 31/03/2021.
//

import UIKit

protocol AutoResizingFullFrame : UIView{
    func resizeToSuperView(view : UIView)
}

extension AutoResizingFullFrame where Self : UIView {
    func resizeToSuperView(view : UIView){
        view.frame = bounds
    }
}

extension UIView : AutoResizingFullFrame {}
