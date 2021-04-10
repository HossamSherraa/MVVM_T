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
   
    private var viewModel : MapViewModel?
    private var subscribtions : Set<AnyCancellable> = []
    internal init(dropOffLocation: Location) {
        self.dropOffLocation = dropOffLocation
        super.init(frame: .zero)
        delegate = self
    }
    
    convenience init(viewModel : MapViewModel , dropOffLocation : Location){
        self.init(dropOffLocation:dropOffLocation)
        self.viewModel = viewModel
        linkeToViewModelState()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dropOffLocation : Location
    private let defaultMapSpan = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    private let mapDropoffLocationSpan = MKCoordinateSpan(latitudeDelta: 0.117, longitudeDelta: 0.117)
    
    func addDropOffLocation( at location : Location){
        let annotation = MapAnnotaion(type: .dropOff, location: location)
        addAnnotation(annotation)
        zoomInTo(location: location) }
    
    private func removeAllAnnotations(){
        annotations.forEach({ removeAnnotation($0)})
    }
    
   private func addPickupLocation(at location : Location){
        removeAllAnnotations()
        let annotaion = MapAnnotaion(type: .pickup, location: location)
        addAnnotation(annotaion)
        zoomInTo(location: location)
    }
    
    private func zoomInTo( location : Location){
        setRegion(.init(center: CLLocationCoordinate2D.init(latitude: location.latitude, longitude: location.longitude), span: mapDropoffLocationSpan), animated: true)
    }
    
    private func linkeToViewModelState(){
        viewModel?
            .$dropOffLocation
            .sink(receiveValue: { [weak self]location in
                self?.addDropOffLocation(at: location)
                self?.zoomInTo(location: location)
            })
            .store(in: &subscribtions)
        
        viewModel?
            .$pickuplocation
            .compactMap({$0})
            .sink(receiveValue: { [weak self] location in
                self?.addPickupLocation(at: location)
                self?.zoomInTo(location: location)
            })
            .store(in: &subscribtions)
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

