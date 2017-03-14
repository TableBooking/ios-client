//
//  DataApiForTesting.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 3/14/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import UIKit

class DataApiForTesting: NSObject {
    typealias CompletionClosure = (Result<Any, Error>)->(Void)
    
    static let sharedInstance = DataApiForTesting()
    
    public func getAllRestaurants(completion: @escaping CompletionClosure){
        let data = NSDataAsset(name: "restaurants", bundle: Bundle.main)
        let json = try? JSONSerialization.jsonObject(with: (data!.data), options: JSONSerialization.ReadingOptions.allowFragments)
        
        Parser.parse(json: json!, completion: {(response:(Result<[TBRestaurant], Error>)) in
            switch response {
            case .success(let restaurants): completion(.success(restaurants))

            default:break
            }
        }
        )
        
        
    }
}
