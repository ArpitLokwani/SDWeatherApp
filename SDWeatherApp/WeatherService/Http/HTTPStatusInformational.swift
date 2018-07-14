//
//  HTTPStatusInformational.swift
//  ALNetworkingSwift
//
//  Created by Arpit Lokwani on 7/17/16.
//  Copyright © 2016 Embitel. All rights reserved.
//

import UIKit

class HTTPStatusInformational: HTTPStatusBase {

    override func initWithStatusCode(code: NSInteger) -> HTTPStatus {
        
        switch statusCodes {
        case 100:
            statusDetail = "HTTP/1.1 100 Continue";
            break;
        case 101:
            statusDetail = "HTTP/1.1 101 Switching Protocols";
            break;
        default:
            break
        }
        return self
    }
    
}
