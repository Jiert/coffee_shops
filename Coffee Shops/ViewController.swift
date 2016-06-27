//
//  ViewController.swift
//  Coffee Shops
//
//  Created by Jared Easterday on 6/6/16.
//  Copyright © 2016 Jared Easterday. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import SafariServices

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    let clientID: String = "DBBRH4RXA34LWVAWLLHM1FQMRF3XD5O2YAZK1ACEKE30UFNG"
    let clientSecret: String = "VMJU0TKF45GBZGSURMPDVWMQCU0NNZ1UZRJU3FMXJGSRNR22"
    let version = "20160609"
    let method = "foursquare"
    let mapView = MKMapView()

    var urlString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let status = CLLocationManager.authorizationStatus()

        loadMapView()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100

        switch status {
        case .AuthorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func loadMapView() {
        mapView.frame = self.view.frame
        mapView.showsUserLocation = true
        view.addSubview(mapView)
    }

    func fetchShops() {
        print("fetchShops")

        guard let url = NSURL(string: urlString) else {
            return
        }

        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session  = NSURLSession(configuration: config)
        let dataTask = session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in

            if (error == nil) {
                guard let newData = data else { return }

                do {
                    guard let jsonArray = try NSJSONSerialization.JSONObjectWithData(newData, options: []) as? [String: AnyObject] else {
                        return
                    }

                    guard let venues = jsonArray["response"]?["venues"] else { return }

                    if let shops = (venues as? NSArray) as Array? {
                        self.annotateMapWithLocations(shops)
                    }

                } catch let jsonError as NSError {
                    NSLog("\(jsonError), \(jsonError.localizedDescription)")
                }
            } else {
                NSLog("\(error), \(error?.localizedDescription)")
            }
        }

        dataTask.resume()
    }

    func annotateMapWithLocations(shops: Array<AnyObject>) {
        for shop in shops {
            guard let name = shop.valueForKey("name") else { return }
            guard let location = shop.valueForKey("location") else { return }
            guard let long = location.valueForKey("lng") as! Double? else { return }
            guard let lat = location.valueForKey("lat") as! Double? else { return }

            let center = CLLocationCoordinate2D(latitude: lat, longitude: long)

            let annotation = Annotation(coordinate: center)

            annotation.title = name as? String

            mapView.addAnnotation(annotation)
        }
    }


    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")

        // If it's a relatively recent event, turn off updates to save power.
        let location = locations.last
        let date = location?.timestamp
        let timeSinceNow = date?.timeIntervalSinceNow
        guard let howRecent = timeSinceNow else { return }

        if (abs(howRecent) < 1500) {
            print(abs(howRecent))
            guard let lat = location?.coordinate.latitude else { return }
            guard let lon = location?.coordinate.longitude else { return }

            urlString = "https://api.foursquare.com/v2/venues/search?client_id=\(clientID)&client_secret=\(clientSecret)&ll=\(lat),\(lon)&query=coffee&v=\(version)&m=\(method)"

            let center = CLLocationCoordinate2D(latitude:lat, longitude:lon)
            let region = MKCoordinateRegion(center:center, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))

            mapView.setRegion(region, animated: true)

            fetchShops()
        }
    }


    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
            case .AuthorizedWhenInUse:
                locationManager.startUpdatingLocation()
            case .Denied:
                let alertController = UIAlertController(title: "Authorization Denied", message: "Please provide authorization in settings", preferredStyle: .Alert)
                let alertAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)

                alertController.addAction(alertAction)

                presentViewController(alertController, animated: true, completion: nil)
            default: break
        }
    }
}