//
//  AnnotationView.swift
//  MVVM_T
//
//  Created by Hossam on 31/03/2021.
//

import MapKit
class AnnotationView : MKAnnotationView {
    init(annotation : MKAnnotation , reuseIdentifier : String , image : UIImage) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


