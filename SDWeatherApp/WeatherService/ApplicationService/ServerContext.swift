//
//  ServerContext.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 17/05/17.
//  Copyright © 2017 Arpit Lokwani. All rights reserved.
//

import Foundation

protocol ServerContext{
    
    func domain() -> String
    func api() -> String
    func isAuthRequired() -> Bool
    func isOAuthRequired() -> Bool
    func basicAuth() ->String
    func urlCrendentials() -> URLCredential
    func protectionSpace() -> URLProtectionSpace
    func bannerBaseURL() -> String
    func categoryBaseURL () -> String
    func oAuthClientID() -> String
    func oAuthClientSecret() -> String
    func timeOut() -> NSInteger
    
}
