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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.frame.size = CGSize(width: 375,height: 603)
        scrollView.contentSize = CGSize(width: 375,height: 840)
        view.backgroundColor = Color.TBBackground
        image.image = UIImage(named: "restaurant-test")
        backgroundViewOnImage.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bookButton.backgroundColor = Color.TBGreen
        bookButton.setTitleColor(Color.TBBackground, for: .normal)
        contentView.backgroundColor = Color.TBBackground
        restaurantDescription.backgroundColor = Color.TBBackground
        restaurantDescription.isEditable = false
        navigationController?.navigationBar.tintColor = Color.TBBackground
        
        configureGoogleMap()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
   
    @IBAction func book(_ sender: UIButton) {
        performSegue(withIdentifier: "bookTableSegue", sender: self)
    }
    func configureGoogleMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 1.285, longitude: 103.848, zoom: 15)
        
        let mapView = GMSMapView.map(withFrame: CGRect(origin: CGPoint(x: 0, y: 0), size: self.mapView.frame.size), camera: camera)
        self.mapView.addSubview(mapView)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 1.285, longitude: 103.848)
        marker.title = "Nikitros Rest"
        marker.snippet = "Kiev URK"
        marker.map = mapView
    }
    
}






