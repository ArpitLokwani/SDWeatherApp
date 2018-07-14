//
//  ServerContextLocalHost.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 22/05/17.
//  Copyright © 2017 Arpit Lokwani. All rights reserved.
//

import UIKit

class ServerContextLocalHost: ServerContext {
    
    func domain() -> String {
        return "https://10.99.12.81/searchtest"
    }
    func api() -> String  {
        return "api/"
    }
    func isAuthRequired() -> Bool{
        return false;
    }
    func isOAuthRequired() -> Bool{
        return true;
    }
    func basicAuth() ->String{
        let authString = "service.admin@goldrush.com:Serv1c3Inf0Ax0n"
        let basic = "Basic "
        let authValue = basic + authString
        return authValue
        
    }
    func urlCrendentials() -> URLCredential{
        let creds = URLCredential(user: "service.admin@goldrush.com", password: "Serv1c3Inf0Ax0n", persistence: URLCredential.Persistence.none)
        return creds;
    }
    func protectionSpace() -> URLProtectionSpace{
        let protectionSpace = URLProtectionSpace(host: "193.180.106.19", port: 80, protocol: "http", realm: "193.180.106.19", authenticationMethod: NSURLAuthenticationMethodNTLM)
        return protectionSpace;
    }
    func bannerBaseURL() -> String{
        return "media/"
    }
    func categoryBaseURL () -> String{
        return "/media/catalog/category"
    }
    func productBaseURL () -> String{
        return "media/catalog/product"
        
    }
    func oAuthClientID() -> String{
        return ""
    }
    func oAuthClientSecret() -> String{
        return ""
    }
    func timeOut() -> NSInteger{
        return 30
    }
}
