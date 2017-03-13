//
//  DataApi.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/23/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import Foundation
import Alamofire

typealias CompletionClosure = (Result<Any, Error>)->(Void)


class DataAPI: NSObject {
    
    static let sharedInstance = DataAPI()
    
    public func login(userName: String, password: String, completion: @escaping CompletionClosure){
        
        let urlEnd = "/Account/Login"
        
        let parameters: Parameters = [
            "Email": userName,
            "Password": password
        ]
        
        Alamofire.request(Config.baseURL + urlEnd, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: Config.headers).responseJSON(completionHandler: {response in
        })
    }
    
    public func getAllRestaurants(completion: @escaping CompletionClosure){
        
        let urlEnd = "/Restaurants"
        
        Alamofire.request(Config.baseURL + urlEnd, method: .get, headers: Config.headers).responseJSON(completionHandler: {response in
            Parser.parse(json: response.result.value ?? "", completion: {(response:(Result<[TBRestaurant], Error>)) in
                switch response {
                case .success(let restaurants): completion(.success(restaurants))
                case .failure(_): break
                    
                }
            })
        })
    }
    
    public func getHistory(restaurantId: Int, completion: @escaping CompletionClosure){
        
        let urlEnd = "/Booking/History/"
        
        Alamofire.request(Config.baseURL + urlEnd + String(restaurantId), method: .get, headers: Config.headers).responseString(completionHandler: {response in
            print("")
        })
    }
    
    public func bookTable(restaurantId: Int,time: Date, qty: Int, completion: @escaping CompletionClosure) {
        
        let urlEnd = "/Booking/Reserve/"
        
        let parameters:Parameters = ["RestaurantId":restaurantId,
                                     "Date":time.description,
                                     "Start":time.description,
                                     "End":time.description,
                                     "PeopleCount":2]
        
        Alamofire.request(Config.baseURL + urlEnd, method: .post,parameters: parameters, headers: Config.headers).responseString(completionHandler: {response in
            if response.result.isSuccess {
                completion(.success(""))
            }
        })
        
    }
    
    
    
    public func showReviewsForTable(tableId: String, completion: @escaping CompletionClosure) {
        
        let urlEnd = "/Restaurants"
        
        Alamofire.request(Config.baseURL + urlEnd, method: .get, headers: Config.headers).responseJSON(completionHandler: {response in
            Parser.parse(json: response.result.value ?? "", completion: {(response:(Result<[TBRestaurant], Error>)) in
                switch response {
                case .success(let restaurants): completion(.success(restaurants))
                case .failure(_): break
                    
                }
            })
        })
    }
    
}
