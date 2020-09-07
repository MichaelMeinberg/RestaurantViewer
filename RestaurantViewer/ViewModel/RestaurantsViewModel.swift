//
//  RestaurantsViewModel.swift
//  RestaurantViewer
//
//  Created by Michael on 9/5/20.
//

import Foundation
import CoreLocation

enum businessType {
    case restaurant
    case hairsolon
    case theater
}

class RestaurantsViewModel {
    lazy var restaurants = [YelpBusiness]()
    let yelpBusinessServices = YelpBusinessesServices()
    
    func searchForRestaurantsNearMe () {
        let defaultLocation =  CLLocation(latitude: 38.0000, longitude: -121.0000)
        yelpBusinessServices.businessSearchFromYelp(location: getMyLocation() ?? defaultLocation) { [weak self] (jsonData, error) in
            guard let self = self,  let jsonData = jsonData else { return }
            do {
               //  let businesses = self.decodeFile(jsonData: jsonData)
                let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as! NSDictionary
                
                // print(String(data: jsonData, encoding: .utf8)!)
   //             print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\(String(describing: jsonDict))\n\n++++++++++++++++++++++++++++++++++++++++++++++++")
                //  self.restaurants = self.getbusinessesByType(businesses: businesses!, type: .restaurant)
                let businessesArray = jsonDict["businesses"]! as! [[String:Any]]
                print("------------------------------\n\(String(describing: businessesArray))\n\n---------------------------------------------")
                
                for business in businessesArray  {
                    let yelpBusiness = YelpBusiness(business: business)
                    self.restaurants.append(yelpBusiness)
                    print("Bus info: \(yelpBusiness.name)  \(yelpBusiness.phone)   \(yelpBusiness.displayAddress)")
                }

            } catch {
                
            }
        }
    }
    
    func getMyLocation() -> CLLocation? {
        let locManager = CLLocationManager()
        let myLocation = locManager.location
        return myLocation
    }
}
