//
//  RestaurantsViewModel.swift
//  RestaurantViewer
//
//  Created by Michael on 9/5/20.
//

import Foundation
import CoreLocation
import UIKit

enum businessType {
    case restaurant
    case hairsolon
    case theater
}

class RestaurantsViewModel {
    lazy var restaurants = [YelpBusiness]()
    let yelpBusinessServices = YelpBusinessesServices()

    func searchForRestaurantsNearMe(location: CLLocation, limit: Int, completionHandler: @escaping (Bool, Error?) -> Void)  {
        yelpBusinessServices.businessSearchFromYelp(location: location,
                                                    limit:  limit,
                                                    type: .restaurant,
                                                    completion: { [weak self] (jsonData, error) in
            guard let self = self,  let jsonData = jsonData else { return }
            do {
                if let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? NSDictionary {
                    if let  businessesArray = jsonDict["businesses"] as? [[String:Any]] {
                        self.restaurants.removeAll() // clear out the list, this pull will be all inclusive.
             
                        for business in businessesArray  {
                            let yelpBusiness = YelpBusiness(business: business)
                            self.getImage(business: yelpBusiness)
                            self.restaurants.append(yelpBusiness)
                            
                            print("Business: \(yelpBusiness.description)")
                        }
                    }
                    completionHandler(true,error)
                }
            } catch {
                print("JSONSerialization error:", error)
            }
        })
    }
    
    func getImage(business: YelpBusiness)  {
        YelpBusinessesServices().getImageFromURL(urlStr: business.imageURL) { (imageData, error) in
            if let imageData = imageData {
                business.image = UIImage(data: imageData) ?? UIImage()
            }
        }
    }
}
