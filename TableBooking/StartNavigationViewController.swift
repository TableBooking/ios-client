//
//  StartNavigationViewController.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/19/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit

class StartNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UI
        self.navigationBar.barTintColor = Color.TBGreen
        self.navigationBar.barStyle = .black;
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Map", style: .plain, target: self, action:nil)

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

}
