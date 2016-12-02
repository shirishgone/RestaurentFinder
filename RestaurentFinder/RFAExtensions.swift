//
//  RFAExtensions.swift
//  RestaurentFinder
//
//  Created by shirish gone on 03/11/16.
//  Copyright © 2016 Shirish. All rights reserved.
//

import UIKit
import Foundation


extension UIImageView {
    
    func downloadImageFromUrl(url: String, completion: @escaping (_ result: UIImage) -> Void)
    {
        let url = URL(string: url)
        DispatchQueue.global().async{
            if let data = try? Data(contentsOf: url!)
            {
                if let image = UIImage(data: data)
                {
                    DispatchQueue.main.async{
                        self.image = image
                    }
                    completion(image)
                }
            }
        }
    }
}
