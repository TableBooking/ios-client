//
//  RestaurantPageViewController.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/26/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit

class RestaurantPageViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var backgroundViewOnImage: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var cuisine: UILabel!
    @IBOutlet weak var avarageBill: UILabel!
    @IBOutlet weak var adressForMaps: UILabel!
    @IBOutlet weak var restaurantDescription: UITextView!
    @IBOutlet weak var workingHours: UILabel!
    @IBOutlet weak var mobileNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
}
