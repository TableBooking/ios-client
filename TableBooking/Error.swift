//
//  Error.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/24/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import Foundation

enum Error : Swift.Error {
    case parser(String)
    case networking(String)
}
