//
//  MapView.swift
//  OnTheMap
//
//  Created by Renan Maganha on 21/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @EnvironmentObject var store: Store<AppState, AppAction>
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.delegate = context.coordinator
        var annotations = [MKPointAnnotation]()
        
        for location in store.state.locations {
            let coordinate = CLLocationCoordinate2D(
                latitude: location.latitude, longitude: location.longitude)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = location.firstName + " " + location.lastName
            annotation.subtitle = location.mediaURL
            
            
            annotations.append(annotation)
        }
        
        uiView.addAnnotations(annotations)
        
        if store.state.locations == [] {
            store.send(.reload)
        }

    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var mapViewController: MapView
        
        init(_ control: MapView) {
            self.mapViewController = control
        }
        
        func mapView(_ mapView: MKMapView, viewFor
            annotation: MKAnnotation) -> MKAnnotationView?{
            //Custom View for Annotation
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customView")
            annotationView.canShowCallout = true
            //Your custom image icon
            annotationView.image = UIImage(named: "customPin32px")
            return annotationView
        }
        
    }
}
