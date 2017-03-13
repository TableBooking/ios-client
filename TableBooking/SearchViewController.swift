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
    
    let rowHeight:CGFloat = 130
    let maxPeople = 10
    let stringFormatForPeopleQtyButton = "Table for %i people"
    let dateFormatTimeButton = "MMM dd, yyyy hh:mm a"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var restaurantSearchBar: UISearchBar!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var peopleQtyButton: UIButton!
    @IBOutlet weak var restaurantsTabelView: UITableView!
    
    // MARK: - Views
    
    var peopleQtyPicker: PeopleQtyPickerView!
    var timePicker: DatePickerView!
    
    //Google Places
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    // MARK: - Local Helpers
    
    var chosenTime: Date?
    var chosenQty: UInt?
    var restaurants:[TBRestaurant] = []
    var selectedRestaurant: TBRestaurant?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Colors
        view.backgroundColor = Color.TBBackground
        timeButton.backgroundColor = Color.TBGreen
        timeButton.setTitleColor(Color.TBBackground, for: .normal)
        restaurantsTabelView.backgroundColor = Color.TBBackground
        peopleQtyButton.backgroundColor = Color.TBGreen
        peopleQtyButton.setTitleColor(Color.TBBackground, for: .normal)
        navigationController?.navigationBar.barTintColor = Color.TBGreen
        navigationController?.navigationBar.barStyle = .black;
        
        setDefaultTitleForDateButton()
        setDefaultTitleForTimeButton()
        
        setUpDatePicker()
        setUpQtyPicker()
        
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
                                                 action: #selector(filter(sender:)))
        
        leftBarButtonItem.tintColor = Color.TBBackground
        rightBarButtonItem.tintColor = Color.TBBackground
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        DataAPI.sharedInstance.getAllRestaurants {result in
            switch result {
            case .success(let restaurants):
                self.restaurants =  (restaurants as? [TBRestaurant])!
                self.reloadTableView()
            default:break
            }
        }
        
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
        
        print("Hello")
        reloadTableView()
    }
    
    func filter(sender: UIBarButtonItem){
        self.performSegue(withIdentifier: "filterSearchSegue", sender: self);
        DataAPI.sharedInstance.bookTable(restaurantId: 2, time: Date(), qty: 2, completion: {result in print("")})
    }
    
    
    
    // MARK: - Additional Helpers
    
    func setDefaultTitleForTimeButton() {
        chosenQty = Config.defaultPeopleQtyForTable
        peopleQtyButton.setTitle(String.init(format: stringFormatForPeopleQtyButton, chosenQty!), for: .normal)
    }
    
    func setDefaultTitleForDateButton() {
        chosenTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatTimeButton
        timeButton.setTitle(formatter.string(from: chosenTime!), for: .normal)
    }
    
    func setUpGooglePlaces() {
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        searchController?.searchBar.searchBarStyle = .minimal
        let subView = UIView(frame: CGRect(x: 0,
                                           y: restaurantSearchBar.frame.origin.y - restaurantSearchBar.frame.height,
                                           width: view.frame.width,
                                           height: restaurantSearchBar.frame.height))
        
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        self.definesPresentationContext = true
    }
    
    func setUpDatePicker() {
        timePicker = DatePickerView.instanceFromNib()
        let y = view.frame.height - (timePicker.frame.size.height +
            (tabBarController?.tabBar.frame.height)!)
        timePicker.frameForPeresenting = CGRect(x: 0,
                                                y: y,
                                                width: view.frame.width,
                                                height: timePicker.frame.size.height)
        timePicker.delegate = self
        
        view.addSubview(timePicker)
    }
    
    func setUpQtyPicker() {
        peopleQtyPicker = PeopleQtyPickerView.instanceFromNib()
        let y = view.frame.height - (peopleQtyPicker.frame.size.height +
            (tabBarController?.tabBar.frame.height)!)
        peopleQtyPicker.frameForPeresenting = CGRect(x: 0,
                                                     y: y,
                                                     width: view.frame.width,
                                                     height: peopleQtyPicker.frame.size.height)
        peopleQtyPicker.maxPeopleQty = 10
        peopleQtyPicker.delegate = self
        view.addSubview(peopleQtyPicker)
    }
    
    func reloadTableView() {
        restaurantsTabelView.reloadData();
        
        //fitting talble view to content
        var frame = restaurantsTabelView.frame
        frame.size.height = restaurantsTabelView.contentSize.height
        restaurantsTabelView.frame = frame
    }
    
    
    
    //MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case "restaurantSearchSegue":
            if let restaurantViewController = segue.destination as? RestaurantPageViewController {
                restaurantViewController.restaurant = selectedRestaurant!
            }
        default: break
        }
    }
    
    
}

// MARK: - DatePickerViewDelegate

extension SearchViewController: DatePickerViewDelegate {
    
    func cancelClicked(dateView: DatePickerView) {
        setTimeForButton(time: chosenTime!)
    }
    
    func doneClicked(dateView: DatePickerView, date: Date) {
        chosenTime = date
        setTimeForButton(time: chosenTime!)
    }
    
    func valueChanged(dateView: DatePickerView, date: Date) {
        setTimeForButton(time: date)
    }
    
    func setTimeForButton(time: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatTimeButton
        timeButton.setTitle(formatter.string(from: time), for: .normal)
    }
}

// MARK: - DatePickerViewDelegate

extension SearchViewController: PeopleQtyPickerViewDelegate {
    
    func doneClicked(pickerView: PeopleQtyPickerView, qty: UInt) {
        chosenQty = qty
        let title = String.init(format: stringFormatForPeopleQtyButton, qty)
        peopleQtyButton.setTitle(title, for: .normal)
    }
    
    func cancelClicked(pickerView: PeopleQtyPickerView) {
        let title = String.init(format: stringFormatForPeopleQtyButton, chosenQty!)
        peopleQtyButton.setTitle(title, for: .normal)
    }
    
    func valueChanged(pickerView: PeopleQtyPickerView, qty: UInt) {
        let title = String.init(format: stringFormatForPeopleQtyButton, qty)
        peopleQtyButton.setTitle(title, for: .normal)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "restaurantTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell;
        cell.nameLabel.text = restaurants[indexPath.item].name
        cell.adressLabel.text = restaurants[indexPath.item].location.address
        cell.restImage.image = UIImage(named: restaurants[indexPath.item].imagePath!)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRestaurant = restaurants[indexPath.item]
        performSegue(withIdentifier: "restaurantSearchSegue", sender: self)
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

























