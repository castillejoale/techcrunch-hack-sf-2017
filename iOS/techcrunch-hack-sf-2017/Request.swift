//
//  Request.swift
//  
//
//  Created by Alejandro Castillejo on 9/16/17.
//
//

import Foundation

class Request:NSObject {
    
    let id:Int
    
    init(id:Int) {
        
        self.id = id
        
    }
    
    static func serialize(measurementDictionary:Dictionary<String,Any>) -> Request? {
        
        return Request(id: 0)
        
    }
    
}
