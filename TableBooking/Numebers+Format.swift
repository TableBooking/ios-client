//
//  Float+DecimalString.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/20/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import Foundation



extension Int {
    func format(f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

extension Float {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
