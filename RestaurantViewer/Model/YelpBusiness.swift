//
//  YelpBusinesses.swift
//  RestaurantViewer
//
//  Created by Michael Meinberg on 9/5/20.
//
//   let yelpBusinesses = try? newJSONDecoder().decode(YelpBusinesses.self, from: jsonData)

import Foundation

typealias YelpBusinesses = [YelpBusiness]

// MARK: - YelpBusinesses
class YelpBusiness {
    let id, name: String
    let imageURL: String
    let url: String
    let phone: String
    let reviewCount: Int

    let displayAddress: [String]

    
    // MARK: - Coordinates
    let latitude, longitude: Double
    
    // MARK: Functions
    
    init (business: [String:Any]) {
        id = business["id"] as? String ?? ""
        name = business["name"] as? String ?? ""
        imageURL = business["imageURL"] as? String ?? ""
        url = business["url"] as? String ?? ""
        latitude = business["latitude"] as? Double ?? 0.00
        longitude = business["longitude"] as? Double ?? 0.00
        phone = business["phone"] as? String ?? ""
        reviewCount = business["reviewCount"] as? Int ?? 0
        displayAddress = business["displayAddress"] as? [String] ?? [""]
    }
}
