//
//  YelpBusinessesServices.swift
//  RestaurantViewer
//
//  Created by Michael Meinberg on 9/5/20.
//

import Foundation
import CoreLocation


class YelpBusinessesServices {
    let kYLPAPIHost: String = "api.yelp.com/v3/businesses/search"
    let kYLPErrorDomain: String = "com.yelp.YelpAPI.ErrorDomain"

    lazy var session = URLSession.shared
    
    func businessSearchFromYelp (location: CLLocation,
                                 completion: @escaping (_ resultData: Data?, Error?) -> Void ) {

        let urlString = "https://api.yelp.com/v3/businesses/search?limit=2&location=Roma&locale=it_IT&term=restaurants"
        let urlStringSpacesEncoded = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = URL(string:  urlStringSpacesEncoded)!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let authHeader: String = "Bearer uRp3n9GufA4tGSJ1OoHfXbc8RW9lyt_XvVbNSqnnck61MD5pu3H4eUVqSEIvGnQ3E8bQgHZuHWaPXdis4xCQb1jHHX4GYWbavrn-vAbjYYsn1MbW1GFqBpYTtANVX3Yx"

        request.setValue(authHeader, forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler:
        { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let response = response {
                print(response)
            }
            if let error = error {
                print(error)
            }
            completion(data,error)
        })
        task.resume()
    }
    
}




