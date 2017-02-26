//
//  RestaurantPageViewController.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/26/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit
import GoogleMaps

class RestaurantPageViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var backgroundViewOnImage: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var cuisine: UILabel!
    @IBOutlet weak var avarageBill: UILabel!
    @IBOutlet weak var adressForMaps: UILabel!
    @IBOutlet weak var restaurantDescription: UITextView!
    @IBOutlet weak var workingHours: UILabel!
    @IBOutlet weak var mobileNumber: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    // MARK: - Local Helpers
    
    var restaurant: Restaurant!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.frame.size = CGSize(width: 375,height: 603)
        scrollView.contentSize = CGSize(width: 375,height: 840)
        view.backgroundColor = Color.TBBackground
        backgroundViewOnImage.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bookButton.backgroundColor = Color.TBGreen
        bookButton.setTitleColor(Color.TBBackground, for: .normal)
        contentView.backgroundColor = Color.TBBackground
        restaurantDescription.backgroundColor = Color.TBBackground
        restaurantDescription.isEditable = false
        navigationController?.navigationBar.tintColor = Color.TBBackground
        
        setRestaurantDataForViews()
        configureGoogleMap(lg: restaurant.location.longitude, lt: restaurant.location.latitude)
    }
   
    @IBAction func book(_ sender: UIButton) {
        performSegue(withIdentifier: "bookTableSegue", sender: self)
    }
    
    func setRestaurantDataForViews() {
        image.image = UIImage(named: "restaurant-test")
        name.text = restaurant.name
        adress.text = restaurant.location.address
        cuisine.text = restaurant.cuisines
        avarageBill.text = String(restaurant.averagePrice)
        adressForMaps.text = restaurant.location.address
        restaurantDescription.text = restaurant.desc
        let dateformatter = DateFormatter()
        dateformatter.timeStyle = .short
        dateformatter.dateStyle = .none
        workingHours.text = dateformatter.string(from: restaurant.openingTime!)
            + " - " + dateformatter.string(from: restaurant.closingTime!)
        mobileNumber.text = restaurant.phoneNumber
    }
    
    func configureGoogleMap(lg: Double, lt: Double) {
        let camera = GMSCameraPosition.camera(withLatitude: lt, longitude: lg, zoom: Config.googleMapsZoom)
        
        let mapView = GMSMapView.map(withFrame: CGRect(origin: CGPoint(x: 0, y: 0), size: self.mapView.frame.size), camera: camera)
        self.mapView.addSubview(mapView)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lt, longitude: lg)
        marker.title = "Nikitros Rest"
        marker.snippet = "Kiev URK"
//        mapView.isUserInteractionEnabled = false
        marker.map = mapView
    }
    
}






