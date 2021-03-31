//
//  MapRootView.swift
//  MVVM_T
//
//  Created by Hossam on 31/03/2021.
//

import MapKit
import UIKit
import Combine

class MapRootView : MKMapView {
    internal init(dropOffLocation: Location) {
        self.dropOffLocation = dropOffLocation
        super.init(frame: .zero)
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dropOffLocation : Location
    private let defaultMapSpan = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
    private let mapDropoffLocationSpan = MKCoordinateSpan(latitudeDelta: 0.017, longitudeDelta: 0.017)
    
    func addDropOffLocation( at location : Location){
        let annotation = MapAnnotaion(type: .dropOff, location: location)
        addAnnotation(annotation)
        zoomInTo(location: location) }
    
    private func removeAllAnnotations(){
        annotations.forEach({ removeAnnotation($0)})
    }
    
    func addPickupLocation(at location : Location){
        removeAllAnnotations()
        let annotaion = MapAnnotaion(type: .pickup, location: location)
        addAnnotation(annotaion)
        zoomInTo(location: location)
    }
    
    private func zoomInTo( location : Location){
        setRegion(.init(center: CLLocationCoordinate2D.init(latitude: location.latitude, longitude: location.longitude), span: defaultMapSpan), animated: true)
    }
    
    
    
}

extension MapRootView : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotaion = annotation as? MapAnnotaion{
            let image = annotaion.type.image
            return AnnotationView(annotation: annotaion, reuseIdentifier: annotaion.id , image :image)
        }
        return nil
    }
}

