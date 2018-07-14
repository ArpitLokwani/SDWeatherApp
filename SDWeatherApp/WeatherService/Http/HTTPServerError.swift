//
//  HTTPServerError.swift
//  ALNetworkingSwift
//
//  Created by Arpit Lokwani on 7/17/16.
//  Copyright © 2016 Embitel. All rights reserved.
//

import UIKit

class HTTPServerError: HTTPStatusBase {
    
     func initWithStatusCode(code: NSInteger) -> Any {
      
                switch statusCodes {
                case 500:
                    statusDetail = "HTTP/1.1 500 Internel Server Error";
                    break;
                case 501:
                    statusDetail = "HTTP/1.1 501 Not Implemented";
                    break;
                case 502:
                    statusDetail = "HTTP/1.1 502 Bad Gateway";
                    break;
                case 503:
                    statusDetail = "HTTP/1.1 503 Service Unavailable";
                    break;
                case 504:
                    statusDetail = "HTTP/1.1 504 Gateway Timeout";
                    break;
                case 505:
                    statusDetail = "HTTP/1.1 505 HTTP Version Not Supported";
                    break;
                    
                    
                default:
                    break;
                }
        
            return self;
        }
    
    

}
