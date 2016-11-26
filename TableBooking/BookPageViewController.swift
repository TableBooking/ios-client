//
//  BookPageViewController.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/26/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit

class BookPageViewController: UIViewController {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var messageToUser: UILabel!
    @IBOutlet weak var messageToAdmin: UITextView!
    @IBOutlet weak var bookButton: UIButton!
    
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
    }
    
}
