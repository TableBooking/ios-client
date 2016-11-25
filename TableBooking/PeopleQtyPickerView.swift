//
//  PeopleQtyPickerView.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/25/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit

protocol PeopleQtyPickerViewDelegate {
    func doneClicked(pickerView: PeopleQtyPickerView, qty: UInt)
    func cancelClicked(pickerView: PeopleQtyPickerView)
    func valueChanged(pickerView: PeopleQtyPickerView, qty: UInt)
}

extension PeopleQtyPickerViewDelegate {
    func doneClicked(pickerView: PeopleQtyPickerView, qty: UInt) {}
    func cancelClicked(pickerView: PeopleQtyPickerView) {}
    func valueChanged(pickerView: PeopleQtyPickerView, qty: UInt) {}
}

class PeopleQtyPickerView: UIView {
    
    public var maxPeopleQty: UInt? = 10
    public var qty: UInt?
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    public var frameForPeresenting: CGRect?
    
    var delegate: PeopleQtyPickerViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        picker.delegate = self
        picker.dataSource = self
        isHidden = true
       
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        picker.backgroundColor = UIColor.black.withAlphaComponent(0)
    }
    
    
    public static func instanceFromNib() -> PeopleQtyPickerView {
        return UINib(nibName: "PeopleQtyPickerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! PeopleQtyPickerView
    }
    
    public func presentOverFromBottom(){
        isHidden = false
        moveOutOfView()
        if self.superview != nil {
            UIView.animate(withDuration: 0.5, animations: {
                self.frame = self.frameForPeresenting!
            })
        }
    }
    
    public func hideToBottom(){
        UIView.animate(withDuration: 0.5, animations: {
            self.moveOutOfView()
        })
        
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        if let qty:UInt = self.qty {
            delegate?.doneClicked(pickerView: self, qty: qty)
        }
        hideToBottom()
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.cancelClicked(pickerView: self)
        hideToBottom()
    }
    
    func moveOutOfView() {
        if self.superview != nil {
            var frame = self.frame
            frame.origin.y = (superview?.frame.height)!
            self.frame = frame
        }
    }
}



extension PeopleQtyPickerView: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1) persons"
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Int(maxPeopleQty!)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        qty = UInt(row + 1)
        delegate?.valueChanged(pickerView: self, qty: qty!)
    }
}
