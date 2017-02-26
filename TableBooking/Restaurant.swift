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
    var location:Location!
    var cuisines:String!
    var tables:[Date]!
    var desc: String!
    var averagePrice: Int!
    var imagePath: String?
    var phoneNumber: String?
    var rating:Float?
    var closingTime: Date?
    var openingTime: Date?
}



extension Restaurant: Mappable{
    
    static func mapToModel(o: AnyObject) -> Result<Restaurant, Error> {
        guard let restaurantJSON = o  as? [String: Any],
            let name = restaurantJSON["name"] as? String,
            let description = restaurantJSON["description"] as? String,
            let rating = restaurantJSON["rating"] as? Float,
            let cuisines = restaurantJSON["cuisine"] as? String,
            let phoneNumber = restaurantJSON["phoneNumber"] as? String,
            let imagePath = restaurantJSON["imagePath"] as? String,
            let averageCheck = restaurantJSON["averageCheck"] as? Int,
            let openingTimeUTC = restaurantJSON["openingTime"] as? String,
            let closingTimeUTC = restaurantJSON["closingTime"] as? String,
            let locationJSON = restaurantJSON["location"] as? [String: Any],
            let latitude = locationJSON["latitude"] as? Double,
            let longtitude = locationJSON["longitude"] as? Double,
            let adress = locationJSON["address"] as? String else {
            return .failure(.parser("Error parsing JSON"))
        }
        
        let restaurant = Restaurant()
        
        restaurant.name = name
        restaurant.desc = description
        restaurant.rating = rating
        restaurant.phoneNumber = phoneNumber
        restaurant.averagePrice = averageCheck
        restaurant.imagePath = imagePath
        restaurant.cuisines = cuisines
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        restaurant.location = Location(address: adress, longitude: Double(longtitude), latitude: Double(latitude))
        
        restaurant.openingTime = dateFormatter.date(from: openingTimeUTC)
        restaurant.closingTime = dateFormatter.date(from: closingTimeUTC)
        
        return .success(restaurant)
    }
}
