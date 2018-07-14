//
//  ErrorCodeStatus.swift
//  ALNetworkingSwift
//
//  Created by Arpit Lokwani on 7/17/16.
//  Copyright © 2016 Embitel. All rights reserved.
//

import Foundation

protocol ErrorCodeStatus {
    
    func errorMessage() -> String
    static func getMessageFromCode (messageType:String) -> String
}
