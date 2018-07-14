//
//  ErrorCodeUser.swift
//  ALNetworkingSwift
//
//  Created by Arpit Lokwani on 7/17/16.
//  Copyright © 2016 Embitel. All rights reserved.
//

import UIKit

class ErrorCodeUser: ErrorCodeBase {
    func initWithCode(code:String){
        if code == "DuplicateUidError" {
            errorMessages = "Email id already exists";
        }else if code == "InvalidGrantError" {
            errorMessages = "Please check the credentials";
        }else if code == "UnknownIdentifierError" {
            errorMessages = "Product not found";
        }else if code == "UnknownResourceError" {
            errorMessages = "Product not found";
        }
    }
    
    override func errorMessage() -> String {
        return errorMessages
    }
    
    func getMessageFromCode(messageType: String) -> String {
        if messageType.characters.count == 0  {
            return ""
        }
        self.initWithCode(code: messageType)
        return errorMessages
        
        
    }
    

}
