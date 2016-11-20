//
//  SearchViewController.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/19/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let rowHeight:CGFloat = 103;
    
    @IBOutlet weak var locationSearchBar: UISearchBar!
    @IBOutlet weak var restaurantSearchBar: UISearchBar!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var peopleQtyButton: UIButton!
    @IBOutlet weak var restaurantsTabelView: UITableView!
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //UI
        view.backgroundColor = UIColor.TBBackgroundColor()
        
        timeButton.backgroundColor = UIColor.TBGreenColor()
        timeButton.setTitleColor(UIColor.TBBackgroundColor(), for: .normal)
        peopleQtyButton.backgroundColor = UIColor.TBGreenColor()
        peopleQtyButton.setTitleColor(UIColor.TBBackgroundColor(), for: .normal)
        restaurantsTabelView.backgroundColor = UIColor.TBBackgroundColor()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let leftBarButtonItem = UIBarButtonItem(title: "Map",
                                                style: .plain,
                                                target: self,
                                                action:#selector(openMaps(sender:)));
        
        let rightBarButtonItem = UIBarButtonItem(title: "Filter",
                                                 style: .plain,
                                                 target: self,
                                                 action:#selector(filter(sender:)))
        leftBarButtonItem.tintColor = UIColor.TBBackgroundColor()
        rightBarButtonItem.tintColor = UIColor.TBBackgroundColor()
        tabBarController?.navigationItem.leftBarButtonItem = leftBarButtonItem
        tabBarController?.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //clear up
        tabBarController?.navigationItem.leftBarButtonItem = nil;
        tabBarController?.navigationItem.rightBarButtonItem = nil;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View TableViewDelegate
    
    
    
    // MARK: - View TableViewDataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "restaurantTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell;
        cell.nameLabel.text = "Rest1"
        
        return cell;
    }
    
    // MARK: - Helpers
    
    func openMaps(sender: UIBarButtonItem){
        print("Hello");
        reloadTableView()
    }
    
    func filter(sender: UIBarButtonItem){
        self.performSegue(withIdentifier: "filterSearchSegue", sender: self);
    }
    
    func reloadTableView(){
        restaurantsTabelView.reloadData();
        
        //fitting talble view to content
        var frame = restaurantsTabelView.frame
        frame.size.height = restaurantsTabelView.contentSize.height
        restaurantsTabelView.frame = frame
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
