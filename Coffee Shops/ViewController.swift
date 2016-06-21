//
//  ViewController.swift
//  Coffee Shops
//
//  Created by Jared Easterday on 6/6/16.
//  Copyright © 2016 Jared Easterday. All rights reserved.
//

// NOTE: Not a good idea to store these here, but where?
// NOTEs: https://docs.google.com/document/d/1UGzN1tj4Pr0zfP7Rd9pA0BAweGimEpGpOPxVlWQnEHs/edit#
// 1) Get user location (need to ask for location information)
// 2) Load map kit view
// 3) Make API request with long and location
// 4) Display pins
// 5) Tap on pin for more information

//    Client id
//    DBBRH4RXA34LWVAWLLHM1FQMRF3XD5O2YAZK1ACEKE30UFNG
//    Client secret
//    VMJU0TKF45GBZGSURMPDVWMQCU0NNZ1UZRJU3FMXJGSRNR22


//    https://api.foursquare.com/v2/venues/search?client_id=DBBRH4RXA34LWVAWLLHM1FQMRF3XD5O2YAZK1ACEKE30UFNG&client_secret=VMJU0TKF45GBZGSURMPDVWMQCU0NNZ1UZRJU3FMXJGSRNR22&v=20130815&ll=40.7,-74&query=coffee



import UIKit
import CoreLocation
import MapKit
import SafariServices

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var mapView: MKMapView? = nil
    let clientID: String = "DBBRH4RXA34LWVAWLLHM1FQMRF3XD5O2YAZK1ACEKE30UFNG"
    let clientSecret: String = "VMJU0TKF45GBZGSURMPDVWMQCU0NNZ1UZRJU3FMXJGSRNR22"
    var urlString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MKMapView(frame: self.view.frame)

        if let map = mapView {
            map.showsUserLocation = true
            view.addSubview(map)
        }

        setupLocationManager()
    }

    func loadData() {
        deleteData()

        print("load data")

        guard let url = NSURL(string: urlString) else {
            return
        }

        print("we have an NSURL now")

        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session  = NSURLSession(configuration: config)
        let dataTask = session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            print("datatask complettion block reached")
            if (error == nil) {
                guard let newData = data else { return }

                print("we have newData now")

                do {
                    guard let jsonArray = try NSJSONSerialization.JSONObjectWithData(newData, options: []) as? [String: AnyObject] else {
                        return
                    }

                    let response = jsonArray["response"]
                    guard let venues = response?["venues"] else { return }

                    var myArray = (venues as? NSArray) as Array?

                    if let shops = myArray {
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

            annotation.title = name as! String

            mapView?.addAnnotation(annotation)
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")

        // If it's a relatively recent event, turn off updates to save power.
        let location = locations.last
        let date = location?.timestamp
        let timeSinceNow = date?.timeIntervalSinceNow
        guard let howRecent = timeSinceNow else { return }

        if (abs(howRecent) < 15) {
            guard let lat = location?.coordinate.latitude else { return }
            guard let lon = location?.coordinate.longitude else { return }
            let v = "20160609"
            let m = "foursquare"

            urlString = "https://api.foursquare.com/v2/venues/search?client_id=\(clientID)&client_secret=\(clientSecret)&ll=\(lat),\(lon)&query=coffee&v=\(v)&m=\(m)"

            print("we have a full urlString now: \(urlString)")

            // send these coordinates to the fetch data call
            print("latitude: \(location?.coordinate.latitude)")
            print("longitude: \(location?.coordinate.longitude)")

            let center = CLLocationCoordinate2D(latitude:lat, longitude:lon)
            let region = MKCoordinateRegion(center:center, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))

            if let map = mapView {
                map.setRegion(region, animated: true)
            }

            loadData()
        }
    }

    func setupLocationManager() {
        print("setupLocationManager")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func deleteData() {
        // kill data here
    }
}