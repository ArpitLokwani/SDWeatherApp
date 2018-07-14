//
//  ServiceFactory.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 17/05/17.
//  Copyright © 2017 Arpit Lokwani. All rights reserved.
//

import UIKit

class ServiceFactory: NetworkServiceMock {
    
    var servicesContext:ServiceContext? = nil
    var networkService:AnyObject? = nil
    
    func setServiceContext(context:ServiceContext) -> Void{
        servicesContext = context
    }
    
    func servicesContextes() -> ServiceContext {
        return servicesContext!
    }
    
    func networkServices() -> NetworkServiceMock {
        return  self.getServices(serviceName: "NetworkService")
    }
    
    func applicationServices() -> ApplicaitonDataService {
        return ApplicaitonDataService()
    }
    
    func getServices(serviceName:String) -> NetworkServiceMock {
        // return (servicesContext?.getDependencyProtocol(serviceName))!
        return NetworkServiceMock()
    }
}
