//
//  RFARestaurentsCollectionViewController.swift
//  RestaurentFinder
//
//  Created by shirish gone on 03/11/16.
//  Copyright © 2016 Shirish. All rights reserved.
//
enum UIUserInterfaceIdiom : Int {
    case Unspecified
    
    case Phone // iPhone and iPod touch style UI
    case Pad // iPad style UI
}

import UIKit

private let reuseIdentifier = "RestaurentCellIdentifier"

class RFARestaurentsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{

    var restaurentsList = [RFARestaurent]()
    var imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Lunch Tyme"
        self.fetchRestaurentsList()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        self.imageCache.removeAllObjects()
    }
    @IBAction func mapButtonTouched(_ sender: UIBarButtonItem) {
        // TODO: Present new view controller with a map to show all the restaurents over a map  
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.restaurentsList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RFARestaurentCell
        
        // Configure the cell
        let restaurentObj = self.restaurentsList[indexPath.row]
        cell.nameLabel.text = restaurentObj.name
        cell.categoryLabel.text = restaurentObj.category
        
        // Fetch the image from cache or download if doesnt exists
        let imageUrlString = restaurentObj.backgroundImageUrl!
        if let cacheImage = self.imageCache.object(forKey: imageUrlString as NSString)
        {
            cell.backgroundImageView.image = cacheImage
        }else
        {
            cell.backgroundImageView.image = UIImage(named:"cell_placeholder")
            cell.backgroundImageView.downloadImageFromUrl(url: imageUrlString, completion: { (image) in
               self.imageCache.setObject(image, forKey: imageUrlString as NSString)
            })
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let selectedRestaurent = restaurentsList[indexPath.row]
        self.performSegue(withIdentifier: RFAConstants.Segue.RestaurentListToDetail, sender: selectedRestaurent)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == RFAConstants.Segue.RestaurentListToDetail) {
            let detailViewController = segue.destination as! RFARestaurentDetailViewController
            let selectedRestaurent = sender as! RFARestaurent
            detailViewController.restaurent = selectedRestaurent
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Two column layout for iPad and single column for iPhone
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize.init(width: self.view.bounds.width/2, height: 180)
        }else{
            return CGSize.init(width: self.view.bounds.width, height: 180)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    // Fetch Restaurents list
    func fetchRestaurentsList()
    {
        let totalURLString = RFAConstants.Server.APIBaseURL + RFAConstants.Server.URLEndPoint
        let url = NSURL(string: totalURLString)
        let urlRequest = NSMutableURLRequest(url: url! as URL)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { (data, response, error) in
            
            // Function which takes an error string and displays to user
            func displayError(error : String){
                print("Error is \(error)")
            }

            guard error == nil else{
                displayError(error: "There is an error with the request : \(error)")
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                displayError(error: "status code issue")
                return
            }
            guard let data = data else {
                displayError(error: "data isn't correct")
                return
            }
            let parser = RFAParser()
            do {
                let parsedRestaurents = try parser.parseRestaurents(data: data)!
                DispatchQueue.main.async{
                    self.restaurentsList = parsedRestaurents
                    self.collectionView?.reloadData()
                }
                
            } catch let parseError as NSError {
                displayError(error: "error : \(parseError.localizedDescription)")
            }
        }
        task.resume()
    }
}
