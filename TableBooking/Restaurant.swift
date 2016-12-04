//
//  Restaurant.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 12/3/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit

final class Restaurant: NSObject {
    var restaurantId:String!
    var name:String!
    var location:String!
    var cuisine:[String]!
    var tables:[Date]!
    var desc: String!
    var image: Data?
    var phoneNumber: String?
    var rating:Float?
    var closingTime: Date?
    var openingTime: Date?
}
//"restaurantId":1,
//    "name":"TestRestaurant",
//    "description":null,
//    "rating":0.0,
//    "cuisine":null,
//    "phoneNumber":null,
//    "imagePath":null,
//    "averageCheck":null,
//    "openingTime":"0001-01-01T00:00:00",
//    "closingTime":"0001-01-01T00:00:00",
//    "locationId":null,
//    "location":null,
//    "tables":null,
//    "reviews":null,
//    "bookings":null,
//    "adminId":null,
//    "admin":null}


extension Restaurant: Mappable{
    
    static func mapToModel(o: AnyObject) -> Result<Restaurant, Error> {
        guard let restaurantJSON = o  as? [String: Any],
            let name = restaurantJSON["name"] as? String,
            let description = restaurantJSON["description"] as? String,
            let rating = restaurantJSON["rating"] as? String,
            let cuisines = restaurantJSON["cuisine"] ,
            let phoneNumber = restaurantJSON["phoneNumber"] as? String,
            let imagePath = restaurantJSON["imagePath"],
            let averageCheck = restaurantJSON["averageCheck"] as? Int,
            let openingTimeUTC = restaurantJSON["openingTime"] as? String,
            let closingTimeUTC = restaurantJSON["closingTime"] as? String,
            let location = restaurantJSON["location"],
            let tables = restaurantJSON["tables"] ,
            let reviews = restaurantJSON["reviews"] else {
            return .failure(.parser("No such attribute in JSON."))
        }
        var restaurant = Restaurant()
        restaurant.name = name
        return .success(Restaurant())
    }
}
