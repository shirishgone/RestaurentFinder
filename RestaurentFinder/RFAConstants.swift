//
//  constants.swift
//  RestaurentFinder
//
//  Created by shirish gone on 02/11/16.
//  Copyright © 2016 Shirish. All rights reserved.
//

import Foundation
import UIKit

struct RFAConstants
{
    struct Server
    {
        static let APIBaseURL = "http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/"
        static let URLEndPoint = "restaurants.json"
    }

    struct WebView
    {
        static let BottleRocketUrl = "https://www.bottlerocketstudios.com/"
    }
    
    struct Appearance
    {
        static let NavBarColor = UIColor(red: 67/255, green: 232/255, blue: 149/255, alpha: 1.0)
        static let TabBarColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha:1.0)
        static let TabBarTextFont = UIFont(name: "AvenirNext-Regular", size: 10)
    }

    struct Segue
    {
        static let RestaurentListToDetail = "SegueIdentifierRestaurentDetail"
    }
}
