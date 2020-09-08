//
//  RestuarantsViewController.swift
//  RestaurantViewer
//
//  Created by Michael on 9/5/20.
//

import UIKit
import CoreLocation

class RestuarantsViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: Variables
    let restaurantVM = RestaurantsViewModel()
    var location = CLLocation()
    let locManager = CLLocationManager()
    var currentViewIndex = 0
    var limit = 15
    // var searchDistance = 2000
    var mainImageView = UIImageView()
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    // MARK: View Controller functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        buildUI()
    }
    
    func buildUI() {
        // Main Image of the Business

        mainImageView.contentMode = .scaleAspectFit
        mainImageView.image = UIImage()
        let viewFrame = self.view.frame
        mainImageView.frame = CGRect(x: 20, y:  120, width: viewFrame.size.width - 40, height: 300)
        self.view.addSubview(mainImageView)
    }

    // MARK: IBActions
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if currentViewIndex < restaurantVM.restaurants.count - 1 {
            currentViewIndex += 1
            updateBusinessUI()
            if restaurantVM.restaurants.count - currentViewIndex < 5 { // Down to the final 5?  Reload businesses
                limit += 15
                updateListOfBusinesses()
            }
        }
    }
    
    @IBAction func prevButtonPressed(_ sender: UIButton) {
        if currentViewIndex > 0 {
            currentViewIndex -= 1
            updateBusinessUI()
        }
    }
    
    // MARK: General Functions
    
    func updateBusinessUI() {
        let business = restaurantVM.restaurants[currentViewIndex]
        businessName.text = business.name
        rating.text = String(business.rating)
        address.text = "\(business.street) - \(business.city), \(business.state)"
        mainImageView.image = business.image
    }
    
    // MARK: Find location of device
    func setupLocationManager() {
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locManager.delegate = self
            locManager.startUpdatingLocation()
            locManager.distanceFilter = 2000
        } else {
            print("Location was not authorized by the user")
        }
    }
    
    fileprivate func updateListOfBusinesses() {
        restaurantVM.searchForRestaurantsNearMe(location: location, limit: limit) { [weak self] (sucess, error) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateBusinessUI()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = manager.location!
        updateListOfBusinesses() // This will update the list of of businesses to be local when you move more then 2000 feet, so you get a local list always!
     }
    
   
    
}
