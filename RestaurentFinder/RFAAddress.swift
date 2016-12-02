//
//  RFAAddress.swift
//  RestaurentFinder
//
//  Created by shirish gone on 03/11/16.
//  Copyright © 2016 Shirish. All rights reserved.
//

import Foundation
import CoreLocation

class RFAAddress {
    
    var formattedAddress: String
    var geoCoordinates: CLLocationCoordinate2D
    
    init?(formattedAddress: String, latitude: Double, longitude: Double) {
        self.formattedAddress = formattedAddress
        self.geoCoordinates = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
    }
}
