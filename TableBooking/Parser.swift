//
//  Parser.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/24/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit

protocol Mappable {
    static func mapToModel(o: AnyObject) -> Result<Self, Error>
}

class Parser: NSObject {

    static func parse<T: Mappable>(json: Any, completion: (Result<[T], Error>) -> Void) {
    
            guard let array = json as? [AnyObject] else {
                completion(.failure(.parser("Received json is not valid")));
                return
            }
            
            let result: Result<[T], Error> = Parser.arrayToModels(array)
            completion(result)

    }
    
    private static func arrayToModels<T: Mappable>(_ objects: [AnyObject]) -> Result<[T], Error> {
        
        var convertAndCleanArray: [T] = []
        
        for object in objects {
            
            switch T.mapToModel(o: object) {
            case .success(let model): convertAndCleanArray.append(model)
            case .failure(let error): print(error)
            }
        }
        return .success(convertAndCleanArray)
    }
}
