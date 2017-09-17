//
//  Request.swift
//  
//
//  Created by Alejandro Castillejo on 9/16/17.
//
//

import Foundation

enum RequestNeed: Int {
    
    case nineOneOne = 0
    case FIRSTAID = 1
    case EVACUATION = 2
    case WATER = 3
    case FOOD = 4
    case PHONECHARGE = 5
    case LIGHTS = 6
    case MEDICATION = 7
    case CLOTHING = 8
    
    var description: String {
        switch self {
        case .nineOneOne:
            return "🚑"
        case .FIRSTAID:
            return "⛑"
        case .EVACUATION:
            return "🚁"
        case .WATER:
            return "💧"
        case .FOOD:
            return "🍴"
        case .PHONECHARGE:
            return "🔋"
        case .LIGHTS:
            return "🔦"
        case .MEDICATION:
            return "💊"
        case .CLOTHING:
            return "👖"
        }
    
    }

}

enum RequestStatus: Int {
    
    case Available = 0
    case Claimed = 1
    case Completed = 2
    
//    var description: String {
//        switch self {
//        case .RequestEmoji0:
//            return "🤗"
//        case .RequestEmoji1:
//            return "👍"
//        }
//    }
    
}

class Request:NSObject {
    
    let id:Int
    let latitude:Float
    let longitude:Float
    let name:String
    let dateCreated:Date
    let needs:[RequestNeed]
    let status: RequestStatus
    let personDescription: String
    
    init(id:Int, latitude:Float, longitude:Float, name:String, dateCreated:Date, needs:[RequestNeed], status:RequestStatus, personDescription:String) {
        
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.dateCreated = dateCreated
        self.needs = needs
        self.status = status
        self.personDescription = personDescription
        
    }
    
    static func serialize(dictionary:Dictionary<String,Any>) -> Request? {
        
        //            print(sessionDictionary)
        
        if let id = dictionary["pk"] as? Int {

            if let longitude = dictionary["longitude"] as? Float {
                
                if let latitude = dictionary["latitude"] as? Float {
                    
                    if let name = dictionary["name"] as? String {
                        
                        if let dateString = dictionary["created_on"] as? String {
                            
                            let date = Date()
                            
                            if let personDescription = dictionary["message"] as? String {
                                
                                if let status = dictionary["status"] as? Int {
                                    
                                    let requestStatus = RequestStatus.init(rawValue: status)
                                    
                                    var needsArray:[RequestNeed] = []
                                    
                                    if let needs = dictionary["needs"] as? Array<Any> {
                                        
                                        for need in needs  {
                                            
                                            if let need = need as? Dictionary<String, Int> {
                                                
                                                needsArray.append(RequestNeed.init(rawValue: need["need"]!)!)
                                                
//                                                print(need)
                                                
                                            }

                                        }
                                        
                                    }
                                    
                                    return Request(id: id, latitude: latitude, longitude: longitude, name: name, dateCreated: date, needs:needsArray, status:requestStatus!, personDescription:personDescription)
                                }
 
                            }
                            
                        }
                        
                    }
                    
                }
            
            }
            
        }
        
        return nil
        
        
    }
    
    
    
}
