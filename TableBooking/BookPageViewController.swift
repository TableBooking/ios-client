//
//  BookPageViewController.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/26/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit

class BookPageViewController: UIViewController {
    
    // MARK: - Constants
    
    let stringFormatForPeopleQtyButton = "Table for %i people"
    let dateFormatTimeButton = "MMM dd, yyyy hh:mm a"
    
    
    // MARK: - Local Helpers
    
    var chosenTime: Date?
    var chosenQty: UInt?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var peopleQtyButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var messageToUser: UILabel!
    @IBOutlet weak var messageToAdmin: UITextView!
    @IBOutlet weak var bookButton: UIButton!
    
    var peopleQtyPicker: PeopleQtyPickerView!
    var timePicker: DatePickerView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.TBBackground
        
        timeButton.backgroundColor = Color.TBGreen
        timeButton.setTitleColor(Color.TBBackground, for: .normal)
        
        bookButton.backgroundColor = Color.TBGreen
        bookButton.setTitleColor(Color.TBBackground, for: .normal)
        
        peopleQtyButton.backgroundColor = Color.TBGreen
        peopleQtyButton.setTitleColor(Color.TBBackground, for: .normal)
        
        messageToAdmin.backgroundColor = Color.TBBackgroundForTextInput
        navigationController?.navigationBar.tintColor = Color.TBBackground
        
        setDefaultTitleForTimeButton()
        setDefaultTitleForDateButton()
        setUpDatePicker()
        setUpQtyPicker()
        
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
    
    // MARK: - User Interaction
    
    @IBAction func book(_ sender: UIButton) {
        
    }
    
    @IBAction func setTime(_ sender: UIButton) {
        timePicker.presentOverFromBottom()
    }
    
    @IBAction func setPeopleQty(_ sender: UIButton) {
        peopleQtyPicker.presentOverFromBottom()
    }
    
    // MARK: - Additional Helpers
    
    func setUpDatePicker() {
        
        timePicker = DatePickerView.instanceFromNib()
        timePicker.picker.minuteInterval = 15
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
    
}

// MARK: - DatePickerViewDelegate

extension BookPageViewController: DatePickerViewDelegate {
    
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

extension BookPageViewController: PeopleQtyPickerViewDelegate {
    
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

extension BookPageViewController: UITextViewDelegate {
    
}

