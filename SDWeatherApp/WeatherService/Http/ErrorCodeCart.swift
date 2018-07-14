//
//  ErrorCodeCart.swift
//  ALNetworkingSwift
//
//  Created by Arpit Lokwani on 7/17/16.
//  Copyright © 2016 Embitel. All rights reserved.
//

import UIKit

class ErrorCodeCart: ErrorCodeBase {
    
    func initWithCode(code:String)
    {
        if code == "UnknownIdentifierError" {
            
            errorMessages = "Product not exists";
        }
            
        else if code == "CommerceCartModificationError" {
            
            errorMessages = "Product not exists";
        }
            
        
    }
    
    override func errorMessage() -> String {
        return errorMessages
        
    }
    
    func getMessageFromCode(messageType: String) -> String {
        
        if messageType.characters.count == 0  {
            
            return ""
            
        }
        
        return errorMessages
        
    }

    
}
