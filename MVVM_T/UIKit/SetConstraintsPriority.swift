//
//  SetConstraintsPriority.swift
//  MVVM_T
//
//  Created by Hossam on 03/04/2021.
//

import UIKit

extension NSLayoutConstraint {
    func setPriority(_ p : UILayoutPriority)->NSLayoutConstraint{
        self.priority = p
        return self
    }
}
