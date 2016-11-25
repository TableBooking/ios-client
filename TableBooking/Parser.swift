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

    func parse<T: Mappable>(_ data: Data, completion: (Result<[T], Error>) -> Void) {
        
        switch decodeData(data) {
            
        case .success(let result):
            
            guard let array = result as? [AnyObject] else {
                completion(.failure(.parser("")));
                return
            }
            
            let result: Result<[T], Error> = arrayToModels(array)
            completion(result)
            
        case .failure:
            completion(.failure(.parser("")))
        }
    }
    
    private func arrayToModels<T: Mappable>(_ objects: [AnyObject]) -> Result<[T], Error> {
        
        var convertAndCleanArray: [T] = []
        
        for object in objects {
            
            guard case .success(let model) = T.mapToModel(o: object) else { continue }
            convertAndCleanArray.append(model)
        }
        
        return .success(convertAndCleanArray)
    }
    
    private func decodeData(_ data: Data) -> Result<Any, Error> {
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
            return .success(json)
        }
        catch {
            return .failure(.parser(""))
        }
    }
}
