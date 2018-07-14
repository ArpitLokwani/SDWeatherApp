//
//  ErrorCodeBase.swift
//  ALNetworkingSwift
//
//  Created by Arpit Lokwani on 7/17/16.
//  Copyright © 2016 Embitel. All rights reserved.
//

import UIKit


class ErrorCodeBase: NSObject,ErrorCodeStatus {
    

    var errorMessages : String!
 
    func errorMessage() -> String {
        
        return errorMessages
    }
    
   static func getMessageFromCode(messageType: String) -> String {
    
        return "Bad Reqeust"

    
    }
    
//    func initWithCode(code:String)->Any
//    {
//        errorMessages = "Bad Request"
//        
//    }
    
}
