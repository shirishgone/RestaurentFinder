//
//  RFAParser.swift
//  RestaurentFinder
//
//  Created by shirish gone on 04/11/16.
//  Copyright © 2016 Shirish. All rights reserved.
//

import Foundation

enum SerializationError: Error {
    case missing(errorDescription: String)
    case invalid(String, Any)
}

class RFAParser {
    
    func parseRestaurents(data: Data) throws -> [RFARestaurent]?
    {
        var restaurentsList = [RFARestaurent]()
        var parsedData : [String: Any]? = nil
        
        do
        {
           parsedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]
        }catch
        {
            throw SerializationError.missing(errorDescription: "Json Parsing Failed")
        }
        
        guard let parsedRestaurents = parsedData?["restaurants"] as? [[String:AnyObject]] else {
            throw SerializationError.missing(errorDescription: "Cant find restaurents in JSON")
        }
        
        for restaurent in parsedRestaurents
        {
            guard let location = restaurent["location"] as? [String: Any] else {
               throw SerializationError.missing(errorDescription: "Cant find location of the restaurent")
            }
            
            // Parsing Address
            var address: RFAAddress? = nil
            guard let latitude = location["lat"] as? Double,
                let longitude = location["lng"] as? Double,
                let formattedAddress = location["formattedAddress"] as? [String]
            else {
                throw SerializationError.missing(errorDescription: "location dictionary cannot be parsed")
            }
            
            let addressString = formattedAddress.joined(separator: ",")
            address = RFAAddress.init(formattedAddress: addressString, latitude: latitude , longitude: longitude)!
            
            // Parsing Contact Info
            var twitter : String? = nil
            var phone : String? = nil
            if let contact = restaurent["contact"] as? [String: Any]{
                if let twitterHandle = contact["twitter"] as? String{
                    twitter = "@" + twitterHandle
                }
                if let phoneNumber = contact["formattedPhone"] as? String{
                    phone = phoneNumber
                }
            }
            
            // Constructing Restaurent Object
            let restaurentObj = RFARestaurent.init(name: restaurent["name"] as! String, category: restaurent["category"] as! String, backgroundImageUrl: restaurent["backgroundImageURL"] as! String, address: address, phoneNumber: phone, twitterHandle: twitter)
            
            restaurentsList.append(restaurentObj!)
        }
        return restaurentsList
    }
}
