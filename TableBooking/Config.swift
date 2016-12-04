//
//  Config.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/23/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import Foundation

struct Config {
    static let baseURL = "http://176.38.19.48:5000"
    static let googleApiKey = "AIzaSyCliEhiXf7KuVIgT2xlEacu6VPj2wGmcAQ"
    static let defaultPeopleQtyForTable: UInt = 2
}

struct Color {
    static let TBGreen =  UIColor.rgbColor(redValue: 12, greenValue: 88, blueValue: 90, alpha: 100)
    static let TBBackground = UIColor.rgbColor(redValue: 251, greenValue: 251, blueValue: 246, alpha: 100)
    static let TBBackgroundForTextInput = UIColor.rgbColor(redValue: 236, greenValue: 238, blueValue: 226, alpha: 100)
}
