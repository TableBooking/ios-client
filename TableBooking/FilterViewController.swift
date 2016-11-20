//
//  FilterViewController.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/20/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var sortSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var priceSlider: NMRangeSlider!
    @IBOutlet weak var priceLowerLabel: UILabel!
    @IBOutlet weak var priceUpperLabel: UILabel!
    
    @IBOutlet weak var ratingSlider: NMRangeSlider!
    @IBOutlet weak var ratingLowerLabel: UILabel!
    @IBOutlet weak var ratingUpperLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePriceSliderLabel()
        configureRatingSliderLabel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        labelSliderChanged(ratingSlider)
        labelSliderChanged(priceSlider)
        priceLowerLabel.isHidden = false;
        priceUpperLabel.isHidden = false;
        ratingLowerLabel.isHidden = false;
        ratingUpperLabel.isHidden = false;
    }
    
    
    // MARK: - Price DoubleSlider
    
    func configurePriceSliderLabel(){
        priceSlider.minimumValue = 0
        priceSlider.maximumValue = 999
        priceSlider.lowerValue = 50
        priceSlider.upperValue = 100
        priceSlider.minimumRange = 15
    }
    
    func configureRatingSliderLabel(){
        ratingSlider.minimumValue = 0
        ratingSlider.maximumValue = 5
        ratingSlider.lowerValue = 2
        ratingSlider.upperValue = 3
        ratingSlider.minimumRange = 0.5
    }
    
    func updateLabels(slider: NMRangeSlider, lowerLabel: UILabel, upperLabel: UILabel) {
        
        
        var lowerCenter = CGPoint();
        var lowerLabelDiff = -CGFloat(30)
        var upperCenter = CGPoint()
        var upperLabelDiff = -CGFloat(30)
        
        let currencyLength = 2
        let ratingFormat = "%.01f"
        let priceFormat = "$%.0f"
        
        var minDifferenceUpper:Float?
        var minDifferenceLower:Float?
        
        
        switch slider {
        case priceSlider:
            minDifferenceUpper = Float(125)
            minDifferenceLower = Float(200)
            lowerLabel.text = String(format: priceFormat, slider.lowerValue)
            upperLabel.text = String(format: priceFormat, slider.upperValue)
        case ratingSlider:
            minDifferenceUpper = Float(0.5)
            minDifferenceLower = Float(0.5)
            lowerLabel.text = String(format: ratingFormat, slider.lowerValue)
            upperLabel.text = String(format: ratingFormat, slider.upperValue)
        default: break
        }
        
        
        //changing Y position of the lower label to prevent overlaping
        if((slider.upperValue - slider.lowerValue) < minDifferenceLower!
            && slider.lowerValue > slider.maximumValue/2){
            lowerLabelDiff = CGFloat(30)
        }
        
        //changing position to follow a slider
        lowerCenter.x = (slider.lowerCenter.x + slider.frame.origin.x - CGFloat(currencyLength))
        lowerCenter.y = (slider.center.y + lowerLabelDiff)
        lowerLabel.center = lowerCenter
        
        
        //changing position to follow a slider
        if((slider.upperValue - slider.lowerValue) < minDifferenceUpper!
            && slider.lowerValue < slider.maximumValue/2){
            upperLabelDiff = CGFloat(30)
        }
        
        upperCenter.x = (slider.upperCenter.x + slider.frame.origin.x - CGFloat(currencyLength))
        upperCenter.y = (slider.center.y + upperLabelDiff)
        upperLabel.center = upperCenter
    }
    
    @IBAction func labelSliderChanged(_ sender: NMRangeSlider) {
        switch sender {
        case priceSlider:
            updateLabels(slider: priceSlider,
                         lowerLabel: priceLowerLabel,
                         upperLabel: priceUpperLabel)
        case ratingSlider:
            updateLabels(slider: ratingSlider,
                         lowerLabel: ratingLowerLabel,
                         upperLabel: ratingUpperLabel)
        default: break
        }
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
