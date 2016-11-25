//
//  SearchViewController.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/19/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit
import GooglePlaces

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let rowHeight:CGFloat = 103;
    
    @IBOutlet weak var restaurantSearchBar: UISearchBar!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var peopleQtyButton: UIButton!
    @IBOutlet weak var restaurantsTabelView: UITableView!
    
    //Google Places
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSPlacesClient.provideAPIKey("AIzaSyAScfB7bzP8bmviuaEZFZDB4aA5ZwWniiI")
        
        //UI
        view.backgroundColor = Color.TBBackground
        
        timeButton.backgroundColor = Color.TBGreen
        timeButton.setTitleColor(Color.TBBackground, for: .normal)
        peopleQtyButton.backgroundColor = Color.TBGreen
        peopleQtyButton.setTitleColor(Color.TBBackground, for: .normal)
        restaurantsTabelView.backgroundColor = Color.TBBackground
        
        setUpGooglePlaces()
        
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
        
        leftBarButtonItem.tintColor = Color.TBBackground
        rightBarButtonItem.tintColor = Color.TBBackground
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
    
    func setUpGooglePlaces() {
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        searchController?.searchBar.searchBarStyle = .minimal
        let subView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: restaurantSearchBar.frame.height))
        
        subView.addSubview((searchController?.searchBar)!)
        self.view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        self.definesPresentationContext = true
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

extension SearchViewController: GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: ", place.name)
        print("Place address: ", place.formattedAddress!)
        print("Place attributions: ", place.attributions!)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Swift.Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
}

























