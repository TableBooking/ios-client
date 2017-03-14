//
//  User.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/24/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit

final class TBUser: NSObject  {
    var firstName: String!
    var lastName: String!
    var email: String!
}

extension TBUser: Mappable{

    static func mapToModel(o: AnyObject) -> Result<TBUser, Error> {
        return .success(TBUser())
    }

}
