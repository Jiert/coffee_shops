//
//  MapViewController.swift
//  Coffee Shops
//
//  Created by Jared Easterday on 6/6/16.
//  Copyright © 2016 Jared Easterday. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("mapViewController view did load")

//        if let quakeLoc = quakeLocation,
//            let latitude = quakeLoc.latitude?.doubleValue,
//            let longitude = quakeLoc.longitude?.doubleValue,
//            let quakeTitle = quakeLoc.location,
//            let quakeDepth = quakeLoc.depth {
//            let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//
//            let region = MKCoordinateRegionMakeWithDistance(center, 1000000, 1000000)
//
//            mapView.region = region
//
//            // create the pin
//            let annotation = Annotation(coordinate: center)
//
//            annotation.title = quakeTitle
//            annotation.subtitle = quakeDepth.stringValue
//            
//            mapView.addAnnotation(annotation)
//            
//        }

    }

    // called for every annotaion you add to the map
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        var pin = mapView.dequeueReusableAnnotationViewWithIdentifier(pinID) as? MKPinAnnotationView
//
//        if pin == nil {
//            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinID)
//        }
//
//        pin?.animatesDrop = true
//        pin?.pinTintColor = UIColor.darkGrayColor()
//        pin?.enabled = true
//        pin?.canShowCallout = true
//
//        let button = UIButton(type: UIButtonType.DetailDisclosure)
//
//        pin?.rightCalloutAccessoryView = button
//
//        return pin
//    }
//
//    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        guard let link = quakeLocation?.quakeWeb?.link else { return }
//
//        guard let url = NSURL(string: link) else { return }
//
//        let vc = SFSafariViewController(URL: url)
//        
//        showViewController(vc, sender: nil)
//    }



}
