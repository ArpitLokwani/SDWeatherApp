//
//  Validation.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 5/6/17.
//  Copyright © 2017 Arpit Lokwani. All rights reserved.
//

import Foundation

extension String{
 
    func isEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: emailRegex)
        return emailTest.evaluate(with: self)
    }
    
       func isNumber() -> Bool {
        let mobileNumberPattern = ""
        let mobileNumberPred = NSPredicate(format:"SELF MATCHES,%@",mobileNumberPattern)
        return mobileNumberPred.evaluate(with: self)
    }

    func validatePanCard(cardNumber:String) -> Bool {
        let pancardRegex = "^[A-Z]{5}[0-9]{4}[A-Z]$"
        let cardTestPred = NSPredicate(format:"SELF MATCHES %@",pancardRegex)
        return cardTestPred.evaluate(with: cardNumber)
    }
    
    
}
