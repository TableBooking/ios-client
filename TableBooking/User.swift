//
//  User.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/24/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit
import RealmSwift

final class User: Object  {
    dynamic var firstName: String?
    var lastName: String?
    var email: String?
}

extension User: Mappable{
    static func mapToModel(o: AnyObject) -> Result<User, Error> {
        return .success(User())
    }
}
