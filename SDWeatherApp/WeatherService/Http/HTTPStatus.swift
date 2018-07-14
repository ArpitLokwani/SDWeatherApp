//
//  HTTPStatus.swift
//  ALNetworkingSwift
//
//  Created by Arpit Lokwani on 7/17/16.
//  Copyright © 2016 Embitel. All rights reserved.
//

import Foundation

//-(NSInteger)statusCode;
//-(NSString *)statusDetails;
protocol HTTPStatus {
    
    func isHTTPError() -> Bool
    func initWithStatusCode(code:NSInteger) -> HTTPStatus
    func statusCode() -> NSInteger
    func statusDetails () -> NSString
    
    
    
}