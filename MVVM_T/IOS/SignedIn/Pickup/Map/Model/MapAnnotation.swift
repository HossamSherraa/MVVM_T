//
//  MapAnnotation.swift
//  MVVM_T
//
//  Created by Hossam on 31/03/2021.
//

import MapKit
class MapAnnotaion :  NSObject , MKAnnotation {
    internal init(type: AnnotaionType, location: Location) {
        self.type = type
        self.coordinate = CLLocationCoordinate2D(latitude: location.x, longitude: location.y)
        self.image = type.image
    }

    let type : AnnotaionType
    var coordinate: CLLocationCoordinate2D
    var image : UIImage
    var id : String {
        return (hash ^ hash * 2).description
    }
    
    
    
}
