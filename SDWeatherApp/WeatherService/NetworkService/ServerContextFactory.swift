//
//  ServerContextFactory.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 17/05/17.
//  Copyright © 2017 Arpit Lokwani. All rights reserved.
//

import UIKit

class ServerContextFactory: NSObject {
    
    func localHost() -> ServerContext{
          return ServerContextLocalHost()
    }
    
    func development() -> ServerContext {
        return ServerContextDevelopment()
    }
    func production() -> ServerContext {
        return ServerContextProduction()
    }
    
}
