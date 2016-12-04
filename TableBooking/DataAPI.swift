//
//  DataApi.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/23/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import Foundation
import Alamofire


class DataAPI: NSObject {
    
    static let sharedInstance = DataAPI()
    
    let headers = [
        "Content-Type": "application/x-www-form-urlencoded",
        "User-Agent":"ios-mobile-client"
    ]
    
    public func getShit(){
        
        Alamofire.request(Config.baseURL + "/Home/TestIos", method: .get).responseString { response in
            debugPrint(response)
            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
        }
    }
    
    public func login(userName: String, password: String){
        
        let parameters: Parameters = [
            "Email": "nikita@example.com",
            "Password": "Qqq111"
//            "RememberMe": true
        ]
       
        
        Alamofire.request(Config.baseURL + "/Account/Login", method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON(completionHandler: {response in

            if let cookie = response.response?.allHeaderFields["Set-Cookie"] as? String {
                cookie
            }
            
        })
    }
    
    public func getAllRestaurants(){
 
        Alamofire.request(Config.baseURL + "/Restaurants", method: .get, headers: headers).responseString(completionHandler: {response in
            print(response.result)
        })
        
    }
    
    
    
//    public func signup(userName: String, password)
    
    
    
}
