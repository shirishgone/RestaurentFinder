//
//  Restaurent.swift
//  RestaurentFinder
//
//  Created by shirish gone on 02/11/16.
//  Copyright © 2016 Shirish. All rights reserved.
//

import Foundation

class RFARestaurent {
    var name: String
    var category: String
    var backgroundImageUrl: String?
    var address: RFAAddress?
    var phoneNumber: String?
    var twitterHandle: String?
    
    init?(name: String, category: String, backgroundImageUrl: String, address: RFAAddress? = nil,
          phoneNumber: String? = nil, twitterHandle : String? = nil) {
        // Initialize stored properties.
        self.name = name
        self.category = category
        self.backgroundImageUrl = backgroundImageUrl
        self.address = address!
        self.phoneNumber = phoneNumber
        self.twitterHandle = twitterHandle
    }
}
