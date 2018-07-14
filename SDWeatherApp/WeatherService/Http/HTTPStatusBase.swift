//
//  HTTPStatusBase.swift
//  ALNetworkingSwift
//
//  Created by Arpit Lokwani on 7/17/16.
//  Copyright © 2016 Embitel. All rights reserved.
//

import Foundation

class HTTPStatusBase: NSObject,HTTPStatus {
    
    var statusCodes : Int = 0
    var statusDetail: NSString?
    
    
    func initWithStatusCode(code: NSInteger) -> HTTPStatus {
        statusCodes = code
        statusDetail = "HTTP/1.1 UNKNOWN"
        return self
    }
    
    func isHTTPError() -> Bool {
        return false
    }

    func statusDetails() -> NSString
    {
        return statusDetail!
    }

    func statusCode() -> NSInteger {
        return statusCodes
    }
    
}
