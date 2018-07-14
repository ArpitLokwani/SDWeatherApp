//
//  HTTPStatusTranslator.swift
//  ALNetworkingSwift
//
//  Created by Arpit Lokwani on 7/17/16.
//  Copyright © 2016 Embitel. All rights reserved.
//

import UIKit

class HTTPStatusTranslator:HTTPStatusBase {
 
    var currentStatus:HTTPStatus!
    let httpStatusInformationalinstance = HTTPStatusInformational()
    let httpStatusSuccesfulinstance = HTTPStatusSuccesful()
    let httpStatusRedirectinalinstance = HTTPStatusRedirection()
    let httpStatusClientErrorinstance = HTTPStatusClientErro()
    let httpStatusServerErrorinstance = HTTPServerError()
    
    override func initWithStatusCode(code: NSInteger) -> HTTPStatus {
         self.setStatusCode(code: code)
        return self
        
    }
    
    func setStatusCode(code:NSInteger) -> Void {
        
        let httpStatusInformationalinstance = HTTPStatusInformational()
        
     let firstDigit = self.getCodeStartIndexDigit(code: code)
        
        var status : HTTPStatus!
        switch firstDigit {
        case 1:
            status = httpStatusInformationalinstance.initWithStatusCode(code: code)
            break
        case 2:
            status = httpStatusSuccesfulinstance.initWithStatusCode(code: code)
            break;
        case 3:
            status = httpStatusRedirectinalinstance.initWithStatusCode(code: code)
            break;
        case 4:
            status = httpStatusClientErrorinstance.initWithStatusCode(code: code)
            break;
        case 5:
            status = httpStatusServerErrorinstance.initWithStatusCode(code: code)
            break;

        default:
            break
        }
        
        return currentStatus = status
    }
    
    
    func getCodeStartIndexDigit(code:NSInteger) -> NSInteger{
        let length = code.description.characters.count
        let digit = code/Int(pow(Double(10), Double(length-1)))%10
        return digit;
        
    }
    
    override func statusCode() -> NSInteger {
        return currentStatus.statusCode()
    }
    
    

    override func statusDetails() -> NSString {
        
        return currentStatus.statusDetails()
    }
    
    override func isHTTPError() -> Bool {
        return currentStatus.isHTTPError()
        
    }
    
    
    

    
}
