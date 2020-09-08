//
//  YelpBusinesses.swift
//  RestaurantViewer
//
//  Created by Michael Meinberg on 9/5/20.
//
//   let yelpBusinesses = try? newJSONDecoder().decode(YelpBusinesses.self, from: jsonData)

import UIKit

class YelpBusiness {
    let id, name: String
    let imageURL: String
    var image: UIImage
    let url: String
    let phone: String
    let reviewCount: Int
    let rating: Int
    let street: String
    let city: String
    let state: String
    let zipcode: String

    // MARK: - Coordinates
    let latitude, longitude: Double
    
    // MARK: Functions
    
    init (business: [String:Any]) {
        id = business["id"] as? String ?? ""
        name = business["name"] as? String ?? ""
        imageURL = business["image_url"] as? String ?? ""
        url = business["url"] as? String ?? ""
        phone = business["phone"] as? String ?? ""
        reviewCount = business["review_count"] as? Int ?? 0
        rating = business["rating"] as? Int ?? 0
        
        let coordinates = business["coordinates"] as! [String:Any]
        latitude = coordinates["latitude"] as? Double ?? 0.00
        longitude = coordinates["longitude"] as? Double ?? 0.00
        
        let location = business["location"] as! [String:Any]
        street = location["address1"] as? String ?? ""
        city = location["city"] as? String ?? ""
        state = location["state"] as? String ?? ""
        zipcode = location["zip_code"] as? String ?? ""
  
        image = UIImage()
    }
    
    var description: String {
        return "\(name)\n\(phone)\n\(reviewCount)\n\(street)\n\(city),\(state) \(zipcode)\nLocation:\(longitude),\(latitude)\n\(imageURL)\n"
    }
}

// MARK: - YelpBusinesses
typealias YelpBusinesses = [YelpBusiness]

