//
//  PickupLocationPickerViewController.swift
//  MVVM_T
//
//  Created by Hossam on 31/03/2021.
//

import Foundation
class PickupLocationPickerViewController : NiblessNavigationViewController {
    
    init(pickupLocationPickerFactory : PickupLocationPickerFactory) {
        super.init(rootViewController: PickupLocationPickerViewContentController(pickupLocationPickerFactory: pickupLocationPickerFactory))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
