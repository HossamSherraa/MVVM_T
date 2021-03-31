//
//  AnnotataionType.swift
//  MVVM_T
//
//  Created by Hossam on 31/03/2021.
//
import UIKit
enum AnnotaionType {
    case dropOff
    case pickup
    
    var image : UIImage {
        switch self {
        case .dropOff: return  #imageLiteral(resourceName: "MapMarkerPickupLocation")
        case .pickup: return #imageLiteral(resourceName: "MapMarkerDropoffLocation")
        }
    }
}
