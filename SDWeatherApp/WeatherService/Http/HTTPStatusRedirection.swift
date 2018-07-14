//
//  HTTPStatusRedirection.swift
//  ALNetworkingSwift
//
//  Created by Arpit Lokwani on 7/17/16.
//  Copyright © 2016 Embitel. All rights reserved.
//

import UIKit

class HTTPStatusRedirection: HTTPStatusBase {

    

     func initWithStatusCode(code: NSInteger) -> Any {
        switch statusCodes {
        case 300:
            statusDetail = "HTTP/1.1 300 Multiple Choices";
            break;
        case 301:
            statusDetail = "HTTP/1.1 301 Moved Permanently";
            break;
        case 302:
            statusDetail = "HTTP/1.1 302 Found";
            break;
        case 303:
            statusDetail = "HTTP/1.1 303 See Other";
            break;
        case 304:
            statusDetail = "HTTP/1.1 304 Not Modified";
            break;
        case 305:
            statusDetail = "HTTP/1.1 305 Use Proxy";
            break;
        case 306:
            statusDetail = "HTTP/1.1 306 (Unused)";
            break;
        case 307:
            statusDetail = "HTTP/1.1 307 Temporary Redirect";
            break;
            
        default:
            break;

    }
    return self;
    }

}
