//
//  JsonParser.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 17/05/17.
//  Copyright © 2017 Arpit Lokwani. All rights reserved.
//

import Foundation

struct ResponseParser {
    func parseResponses(data:NSData,completetionHandler:(_ success:Bool,_ data:NSData,_ response:AnyObject)->Void) -> Void {
        do {
            let error:NSError? = nil
            if let jsonObject: AnyObject = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments)  as AnyObject? {
                if let dict = jsonObject as? NSDictionary {
                    print(dict)
                    completetionHandler(true,data,dict)
                } else {
                    print("not a dictionary")
                    let dataString = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)
                    // print("this is real data \(dataString!)")
                    completetionHandler(true,data,dataString!)
                }
            } else {
                print("Could not parse JSON: \(error!)")
            }
        } catch {
            
            // Something went wrong
        }
    }
    
    func isSuccess(responseDict:NSDictionary?) -> Bool {
        if (responseDict == nil || responseDict?.count==0) {
            return false
        }
        if responseDict?.object(forKey: "status")as! String == "success" {
            return true
        }
        return false
    }
    
    func isFailure(responseDict:NSDictionary) -> Bool {
        if (responseDict.value(forKey: "errors") != nil){
        if (ObjectUtils.getObjectFrom(dictionary: responseDict, Key: "errors" as AnyObject)?.count)!>0 {
            return true
        }
        return false
        }
        return false
        
    }
    
    func failureMessage(response:NSDictionary?) -> String? {
        print(response ?? "")
        if response?.object(forKey: "status")as! String == "failure"
        {
            return ObjectUtils.getStringFrom(dictionary: response!, key: ("errorMessage"))
        }
        return nil
    }
    
    
}
