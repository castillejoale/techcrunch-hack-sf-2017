//
//  WebService.swift
//  techcrunch-hack-sf-2017
//
//  Created by Alejandro Castillejo on 9/16/17.
//  Copyright © 2017 propelland. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class WebService {
    
    static let sharedInstance = WebService()
    
    let baseURL = "http://aed5484b.ngrok.io/"
    
    func httpRequest(urlString:String, parameters: [String: Any?]?, method:HTTPMethod, completionFunction:((NSError?,Dictionary<String, Any>) -> ())?) {
        
        print(urlString)
        
        if let _ = parameters {
            //            print(parameters!)
        } else {
            print("No parameters")
        }
        
        var headers: [String: String]? = nil
        
        //        print(headers)
        
        Alamofire.request(urlString, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            print(response)
            
            if ((completionFunction) != nil) {
                
                if let responseValue = response.result.value {
                    
                    let json = JSON(responseValue)
                    
                    let responseCode = response.response?.statusCode ?? 400
                    
                    var jsonDictionary:NSDictionary? = nil
                    
                    if let _ = json.dictionaryObject {
                        jsonDictionary = json.dictionaryObject! as NSDictionary
                    }
                    
                    if let jsonArray = json.arrayObject {
                        jsonDictionary = ["array":jsonArray]
                    }
                    
                    if let dict = jsonDictionary as? Dictionary<String,Any> {
                        
                        let successful = (200..<300).contains(responseCode)
                        
                        if successful {
                            
                            completionFunction!(nil, dict)
                            return
                            
                        } else {
                            
                            var errorString:String? = nil
                            
                            var keys = Array(dict.keys)
                            
                            if keys.count > 0 {
                                
                                let firstKey = keys[0]
                                
                                let value = dict[firstKey] as Any
                                
                                if !(firstKey == "non_field_errors") {
                                    errorString = firstKey + ": "
                                }
                                
                                let jsonError = JSON(value as Any)
                                if let jsonErrorArray = jsonError.arrayObject {
                                    if jsonErrorArray.count > 0 {
                                        if let string = jsonErrorArray[0] as? String {
                                            if let _ = errorString {
                                                errorString = errorString! + string
                                            } else {
                                                errorString = string
                                            }
                                        }
                                    }
                                }
                                
                            }
                            
                            let error = NSError(domain: errorString ?? "No description", code: 0, userInfo: nil)
                            completionFunction!(error, dict)
                            return
                            
                        }
                        
                        let error = NSError()
                        completionFunction!(error, dict)
                        return
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
