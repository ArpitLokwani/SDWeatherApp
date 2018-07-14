//
//  ObjectUtils.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 17/05/17.
//  Copyright © 2017 Arpit Lokwani. All rights reserved.
//

import UIKit

class ObjectUtils: NSObject {
    static func getObjectFrom(dictionary:NSDictionary,Key:AnyObject) -> AnyObject?
    {
        if  dictionary.count == 0  {
            return "" as AnyObject?
        }
        let value = dictionary.object(forKey: Key)
        if  value != nil{
            return value! as AnyObject?
        }
        return nil
    }
    
    static func getStringFrom(dictionary:NSDictionary?,key:String?) -> String?
    {
        if  dictionary?.count == 0  {
            return ""
        }
        let value = dictionary?.object(forKey: key ?? "")
        if ((value) != nil){
            print(value ?? "")
            return value as! String?
            
        }
        return ""
    }
    
    func isNotNull(object:AnyObject?) -> Bool {
        guard let object = object else {
            return false
        }
        
        return (isNotNSNull(object: object) && isNotStringNull(object: object))
    }
    
    func isNotNSNull(object:AnyObject) -> Bool {
        return object.classForCoder != NSNull.classForCoder()
    }
    
    func isNotStringNull(object:AnyObject) -> Bool {
        if let object = object as? String, object.uppercased() == "NULL" {
            return false
        }
        return true
    }
}
