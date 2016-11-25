//
//  Result.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/24/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import Foundation

enum Result<T, Error> {
    case success(T)
    case failure(Error)
}
