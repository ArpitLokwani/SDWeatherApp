//
//  HTTPStatusClientErro.swift
//  ALNetworkingSwift
//
//  Created by Arpit Lokwani on 7/17/16.
//  Copyright © 2016 Embitel. All rights reserved.
//

import UIKit

class HTTPStatusClientErro: HTTPStatusBase {
    
     func initWithStatusCode(code: NSInteger) -> Any {
       
        switch statusCodes {
        case 400:
            statusDetail = "HTTP/1.1 400 Bad Request"
            break
            
            
        case 401:
          
                statusDetail = "HTTP/1.1 401 Unauthorized";
                // [OAuthProvider clearAuthInformation];
                // id <ApplicationService> applicationService = [ServicesFactory applicationService];
                // [applicationService clearConfiguration];
                break;
          
        case 402:
            statusDetail = "HTTP/1.1 402 Payment Required";
            break;
        case 403:
            statusDetail = "HTTP/1.1 403 Forbidden";
            break;
        case 404:
            statusDetail = "HTTP/1.1 404 Not Found";
            break;
        case 405:
            statusDetail = "HTTP/1.1 405 Method Not Allowed";
            break;
        case 406:
            statusDetail = "HTTP/1.1 406 Not Acceptable";
            break;
        case 407:
            statusDetail = "HTTP/1.1 407 Proxy Authentication Required";
            break;
        case 408:
            statusDetail = "HTTP/1.1 408 Request Timeout";
            break;
        case 409:
            statusDetail = "HTTP/1.1 409 Conflict";
            break;
        case 410:
            statusDetail = "HTTP/1.1 410 Gone";
            break;
        case 411:
            statusDetail = "HTTP/1.1 411 Length Required";
            break;
        case 412:
            statusDetail = "HTTP/1.1 412 Precondition Failed";
            break;
        case 413:
            statusDetail = "HTTP/1.1 413 Request Entity Too Large";
            break;
        case 414:
            statusDetail = "HTTP/1.1 414 Request-URI Too Long";
            break;
        case 415:
            statusDetail = "HTTP/1.1 415 Unsupported Media Type";
            break;
        case 416:
            statusDetail = "HTTP/1.1 416 Requested Range Not Satisfiable";
            break;
        case 417:
            statusDetail = "HTTP/1.1 417 Expectation Failed";
            break;

            
        default:
            break
        }
    
        return self
    }
    
    override func isHTTPError() -> Bool {
        return true
        
    }
    
}
