//
//  DatePickerView.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/25/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit

import UIKit

protocol DatePickerViewDelegate {
    func doneClicked(dateView: DatePickerView, date: Date)
    func cancelClicked(dateView: DatePickerView)
    func valueChanged(dateView: DatePickerView, date: Date)
}

extension DatePickerViewDelegate {
    func doneClicked(dateView: DatePickerView, date: Date) {}
    func cancelClicked(dateView: DatePickerView) {}
    func valueChanged(dateView: DatePickerView, date: Date) {}
}

class DatePickerView: UIView {
    
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    public var frameForPeresenting: CGRect?
    
    var delegate: DatePickerViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isHidden = true
        
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        picker.backgroundColor = UIColor.black.withAlphaComponent(0)
    }
    
    
    public static func instanceFromNib() -> DatePickerView {
        return UINib(nibName: "DatePickerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DatePickerView
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
        if let datePicker = picker {
            delegate?.doneClicked(dateView: self, date: datePicker.date)
        }
        hideToBottom()
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.cancelClicked(dateView: self)
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
