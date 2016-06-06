//
//  ViewController.swift
//  Coffee Shops
//
//  Created by Jared Easterday on 6/6/16.
//  Copyright © 2016 Jared Easterday. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // NOTEs: https://docs.google.com/document/d/1UGzN1tj4Pr0zfP7Rd9pA0BAweGimEpGpOPxVlWQnEHs/edit#
    // 1) Get user location (need to ask for location information)
    // 2) Load map kit view
    // 3) Make API request with long and location
    // 4) Display pins
    // 5) Tap on pin for more information

    let clientID: String = "DBBRH4RXA34LWVAWLLHM1FQMRF3XD5O2YAZK1ACEKE30UFNG"
    let clientSecret: String = "VMJU0TKF45GBZGSURMPDVWMQCU0NNZ1UZRJU3FMXJGSRNR22"
    let urlString: String = "https://api.foursquare.com/v2/venues/search?client_id=\(clientID)&client_secret=\(clientSecret)&ll=&query=coffee"

//    Client id
//    DBBRH4RXA34LWVAWLLHM1FQMRF3XD5O2YAZK1ACEKE30UFNG
//    Client secret
//    VMJU0TKF45GBZGSURMPDVWMQCU0NNZ1UZRJU3FMXJGSRNR22


//    https://api.foursquare.com/v2/venues/search?client_id=DBBRH4RXA34LWVAWLLHM1FQMRF3XD5O2YAZK1ACEKE30UFNG&client_secret=VMJU0TKF45GBZGSURMPDVWMQCU0NNZ1UZRJU3FMXJGSRNR22&v=20130815&ll=40.7,-74&query=coffee

    func refreshData() {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session  = NSURLSession(configuration: config)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

