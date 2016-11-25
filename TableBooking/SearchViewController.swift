//
//  SearchViewController.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/19/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit
import GooglePlaces

class SearchViewController: UIViewController {
    
    // MARK: - Constants
    
    let rowHeight:CGFloat = 103
    let maxPeople = 10
    let formatForPeopleQtyButton = "Table for %i people"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var restaurantSearchBar: UISearchBar!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var peopleQtyButton: UIButton!
    @IBOutlet weak var restaurantsTabelView: UITableView!
    
    // MARK: - Views
    
    var peopleQtyPicker: PeopleQtyPickerView!
    var timePicker: DatePickerView!

    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSPlacesClient.provideAPIKey(Config.googleApiKey)
        
        //UI
        view.backgroundColor = Color.TBBackground
        timeButton.backgroundColor = Color.TBGreen
        timeButton.setTitleColor(Color.TBBackground, for: .normal)
        peopleQtyButton.backgroundColor = Color.TBGreen
        peopleQtyButton.setTitleColor(Color.TBBackground, for: .normal)
        restaurantsTabelView.backgroundColor = Color.TBBackground
        
        setUpDatePicker()
        setUpQtyPicker()
        setUpGooglePlaces()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Tab bar
        let leftBarButtonItem = UIBarButtonItem(title: "Map",
                                                style: .plain,
                                                target: self,
                                                action:#selector(openMaps(sender:)));
        
        let rightBarButtonItem = UIBarButtonItem(title: "Filter",
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(filter(sender:)))
        
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
    
    
    // MARK: - User Interaction
    
    @IBAction func setTime(_ sender: UIButton) {
        timePicker.presentOverFromBottom()
    }
    
    @IBAction func setPeopleQty(_ sender: UIButton) {
        peopleQtyPicker.presentOverFromBottom()
    }
    
    func openMaps(sender: UIBarButtonItem){
        print("Hello");
        reloadTableView()
    }
    
    func filter(sender: UIBarButtonItem){
        self.performSegue(withIdentifier: "filterSearchSegue", sender: self);
    }
    
    
    
    // MARK: - Additional Helpers
    

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
        let subView = UIView(frame: CGRect(x: 0,
                                           y: 0,
                                           width: view.frame.width,
                                           height: restaurantSearchBar.frame.height))
        
        subView.addSubview((searchController?.searchBar)!)
        self.view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        self.definesPresentationContext = true
    }
    
    func setUpDatePicker(){
        timePicker = DatePickerView.instanceFromNib()
        let y = view.frame.height - (timePicker.frame.size.height +
            (tabBarController?.tabBar.frame.height)! + 50)
        timePicker.frameForPeresenting = CGRect(x: 0,
                                                y: y,
                                                width: view.frame.width,
                                                height: timePicker.frame.size.height)
        timePicker.delegate = self
        
        view.addSubview(timePicker)
    }
    
    func setUpQtyPicker(){
        peopleQtyPicker = PeopleQtyPickerView.instanceFromNib()
        let y = view.frame.height - (peopleQtyPicker.frame.size.height +
            (tabBarController?.tabBar.frame.height)! + 50)
        peopleQtyPicker.frameForPeresenting = CGRect(x: 0,
                                                     y: y,
                                                     width: view.frame.width,
                                                     height: peopleQtyPicker.frame.size.height)
        peopleQtyPicker.maxPeopleQty = 10
        peopleQtyPicker.delegate = self
        view.addSubview(peopleQtyPicker)
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

// MARK: - DatePickerViewDelegate

extension SearchViewController: DatePickerViewDelegate {
    
    
    
    func cancelClicked( dateView: DatePickerView) {
        
    }
    func doneClicked(dateView: DatePickerView, date: Date) {}
    
    func valueChanged(dateView: DatePickerView, date: Date) {}
    
    
}

// MARK: - DatePickerViewDelegate

extension SearchViewController: PeopleQtyPickerViewDelegate {
    
    func doneClicked(pickerView: PeopleQtyPickerView, qty: UInt) {}
    
    func cancelClicked(pickerView: PeopleQtyPickerView) {
        
    }
    
    func valueChanged(pickerView: PeopleQtyPickerView, qty: UInt) {
        peopleQtyButton.titleLabel?.text = String.init(format: formatForPeopleQtyButton, qty)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
}

// MARK: - GMSAutocompleteResultsViewControllerDelegate

extension SearchViewController: GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: ", place.name )
        print("Place address: ", place.formattedAddress ?? "ss")
        print("Place attributions: ", place.attributions ?? "aatt")
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

























