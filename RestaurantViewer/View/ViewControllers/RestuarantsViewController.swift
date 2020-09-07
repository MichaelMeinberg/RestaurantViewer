//
//  RestuarantsViewController.swift
//  RestaurantViewer
//
//  Created by Michael on 9/5/20.
//

import UIKit

class RestuarantsViewController: UIViewController {
    
    // MARK: Variables
    let restaurantVM = RestaurantsViewModel()
    
    
    // MARK: View Controller functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        restaurantVM.searchForRestaurantsNearMe()
    }
    
    
    
    // MARK: General Functions
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
