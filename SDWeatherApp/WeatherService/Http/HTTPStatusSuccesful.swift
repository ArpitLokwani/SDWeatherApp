//
//  HTTPStatusSuccesful.swift
//  ALNetworkingSwift
//
//  Created by Arpit Lokwani on 7/17/16.
//  Copyright © 2016 Embitel. All rights reserved.
//

import UIKit

class HTTPStatusSuccesful: HTTPStatusBase {
     func initWithStatusCode(code: NSInteger) -> Any {
        switch (statusCodes) {
        case 200:
            statusDetail = "HTTP/1.1 200 OK";
            break;
        case 201:
            statusDetail = "HTTP/1.1 201 Created";
            break;
        case 202:
            statusDetail = "HTTP/1.1 202 Accepted";
            break;
        case 203:
            statusDetail = "HTTP/1.1 203 Non-Authoritative Information";
            break;
        case 204:
            statusDetail = "HTTP/1.1 204 No Content";
            break;
        case 205:
            statusDetail = "HTTP/1.1 205 Reset Content";
            break;
        case 206:
            statusDetail = "HTTP/1.1 206 Partial Content";
            break;
            
        default:
            break;
        }
        return self
        
    }

}
