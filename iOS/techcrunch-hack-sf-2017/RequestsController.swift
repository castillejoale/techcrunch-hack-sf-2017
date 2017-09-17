//
//  RequestsController.swift
//  techcrunch-hack-sf-2017
//
//  Created by Alejandro Castillejo on 9/16/17.
//  Copyright © 2017 propelland. All rights reserved.
//

import Foundation

protocol RequestsControllerProtocol {
    
    func getRequestsResponse(errors:[NSError]?)
    
}

class RequestsController: NSObject {
    
    static let sharedInstance = RequestsController()
    var delegate:RequestsControllerProtocol?
    
    var requestsArray: [Request] = []
    
    func getRequestsArray() -> [Request]? {

        return requestsArray
        
    }
    
    //Get team info for id
    func getRequests() {
        
//        let request1 = Request(id: 0, latitude: 10.0, longitude: 10.0, name: "Jordan Lang", dateCreated: Date(), needs: [RequestEmoji.CLOTHING, RequestEmoji.EVACUATION], status: RequestStatus.Available, personDescription:"HEHE")
//        requestsArray.append(request1)
//        
//        let request2 = Request(id: 1, latitude: 30.0, longitude: 120.0, name: "Dwight Davis", dateCreated: Date(), needs: [RequestEmoji.FOOD], status: RequestStatus.Available, personDescription:"HEHE")
//        requestsArray.append(request2)
        
        let urlString = WebService.sharedInstance.baseURL + "api/allquests/"
        
        let parameters: [String: String?] = [:]
        
        let completionFunction: ((NSError?, Dictionary) -> ()) = {(error:NSError?, messageDictionary:Dictionary<String, Any>) in
            
            print(messageDictionary)
            
            if (error == nil) {
                
                if let requests = messageDictionary["array"] as? [Dictionary<String, Any>] {
                    
                    self.requestsArray = []
                    
                    for request in requests {
                        
                        if let requestSerialized = Request.serialize(dictionary: request) {
                            
                            self.requestsArray.append(requestSerialized)
                            
                        }
                        
                    }
                    
                }
                
                self.delegate?.getRequestsResponse(errors: nil)
                
            } else {
                
                self.delegate?.getRequestsResponse(errors: [error!])
                
            }
            
        }
        
        WebService.sharedInstance.httpRequest(urlString: urlString, parameters: nil, method: .get, completionFunction:completionFunction)
        
    }
    
    //Get team info for id
    func updateRequest(request:Request?) {
        
        let urlString = WebService.sharedInstance.baseURL + "api/quests/4"
        
        let parameters: [String: String?] = [
            "status": "1"
        ]
        
        let completionFunction: ((NSError?, Dictionary) -> ()) = {(error:NSError?, messageDictionary:Dictionary<String, Any>) in
            
            print(messageDictionary)
            
            if (error == nil) {
                
//                if let requests = messageDictionary["array"] as? [Dictionary<String, Any>] {
//                    
//                    self.requestsArray = []
//                    
//                    for request in requests {
//                        
//                        if let requestSerialized = Request.serialize(dictionary: request) {
//                            
//                            self.requestsArray.append(requestSerialized)
//                            
//                        }
//                        
//                    }
//                    
//                }
                
                self.delegate?.getRequestsResponse(errors: nil)
                
            } else {
                
                self.delegate?.getRequestsResponse(errors: [error!])
                
            }
            
        }
        
        WebService.sharedInstance.httpRequest(urlString: urlString, parameters: parameters, method: .post, completionFunction:completionFunction)
        
    }
    
    func getRequest(id:Int) -> Request? {
    
        for request in requestsArray {
            
            if request.id == id {
                
                print(id)
                
                return request
                
            }
            
        }
        
        return nil
    
    }
    
    //Get team info for id
    func deleteDwight() {

        let urlString = WebService.sharedInstance.baseURL + "api/ddwight/"
        
        let parameters: [String: String?] = [:]
        
        let completionFunction: ((NSError?, Dictionary) -> ()) = {(error:NSError?, messageDictionary:Dictionary<String, Any>) in
            
            print(messageDictionary)
            
            if (error == nil) {

                
            } else {

                
            }
            
        }
        
        WebService.sharedInstance.httpRequest(urlString: urlString, parameters: nil, method: .get, completionFunction:completionFunction)
        
    }
    
}
