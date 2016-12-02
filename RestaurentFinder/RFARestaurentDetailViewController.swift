//
//  RFARestaurentDetailViewController.swift
//  RestaurentFinder
//
//  Created by shirish gone on 04/11/16.
//  Copyright © 2016 Shirish. All rights reserved.
//

import UIKit
import MapKit

let regionRadius: CLLocationDistance = 2000

class RFARestaurentDetailViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var restaurentNameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    
    var restaurent: RFARestaurent!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initializeUIwith(restaurent: self.restaurent)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeUIwith(restaurent: RFARestaurent)
    {
        self.restaurentNameLabel.text = restaurent.name
        self.categoryLabel.text = restaurent.category
        
        // Drop a pin at the restaurent coordinate
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = (restaurent.address?.geoCoordinates)!
        dropPin.title = restaurent.name
        mapView.addAnnotation(dropPin)
        
        // Zoom the map closer to the given coordinate
        let coordinateRegion = MKCoordinateRegionMakeWithDistance((restaurent.address?.geoCoordinates)!,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        self.addressLabel.text = restaurent.address?.formattedAddress
        self.phoneNumberLabel.text = restaurent.phoneNumber
        self.twitterHandleLabel.text = restaurent.twitterHandle
    }
}
