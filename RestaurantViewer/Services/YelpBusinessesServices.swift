//
//  YelpBusinessesServices.swift
//  RestaurantViewer
//
//  Created by Michael Meinberg on 9/5/20.
//

import Foundation
import CoreLocation


class YelpBusinessesServices {
    let kYLPAPIHost: String = "api.yelp.com/v3/businesses/search?"
    let kYLPErrorDomain: String = "com.yelp.YelpAPI.ErrorDomain"

    lazy var session = URLSession.shared
    
    func businessSearchFromYelp (location: CLLocation,
                                 limit: Int,
                                 type: businessType,
                                 completion: @escaping (_ resultData: Data?, Error?) -> Void ) {

        let urlString = "https://" + kYLPAPIHost 
        + "&longitude=\(location.coordinate.longitude)&latitude=\(location.coordinate.latitude)"
        + "&limit=\(limit)"
        + "&term=restaurants"
        
        let urlStringSpacesEncoded = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        if let url = URL(string:  urlStringSpacesEncoded) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let authHeader: String = "Bearer " + Keys.YELPAPIKEY
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
    
    func getImageFromURL (urlStr: String,
                   completion: @escaping (_ resultData: Data?, Error?) -> Void ) {
        
        if let url = URL(string:  urlStr) {
            let request =  NSMutableURLRequest(url: url)
            request.httpMethod = "GET"
            
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
        } else {
            completion(nil,nil)
        }
    }
    
    
}




