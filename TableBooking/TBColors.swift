//
//  TBColors.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 10/24/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func rgbColor(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: redValue/255.0, green: greenValue/255.0, blue: blueValue/255.0, alpha: alpha)
    }
}
