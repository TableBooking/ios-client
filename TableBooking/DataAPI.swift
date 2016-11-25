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
    
    public func login(userName: String, password: String){
        
        Alamofire.request(Config.baseURL, method: .get).responseJSON { response in
            debugPrint(response)
            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
        }
    }
    
    
}
