//
//  Annotation.swift
//  Coffee Shops
//
//  Created by Jared Easterday on 6/21/16.
//  Copyright © 2016 Jared Easterday. All rights reserved.
//

import MapKit

class Annotation: NSObject, MKAnnotation {

    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
    
}