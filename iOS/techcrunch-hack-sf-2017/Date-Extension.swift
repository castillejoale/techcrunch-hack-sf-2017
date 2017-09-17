//
//  UIDate-Extension.swift
//  techcrunch-hack-sf-2017
//
//  Created by Alejandro Castillejo on 9/16/17.
//  Copyright © 2017 propelland. All rights reserved.
//

import Foundation

extension Date {
    
    static var djangoFormat: String {
        return "yyyy-MM-dd'T'HH:mm:ssZ"
    }
    
    static var djangoAPIFormat: String {
        return "yyyy-MM-dd"
    }

    static var theFormat: String {
        return "hh:mma MM/dd/yy"
    }
    
    func getString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.theFormat
        return dateFormatter.string(from: self)
        
    }
    
}
