//
//  NetworkService.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 17/05/17.
//  Copyright © 2017 Arpit Lokwani. All rights reserved.
//

import Foundation

protocol NetworkService {
    func setServerContext(context:ServerContext) -> Void
    func serversContext()->ServerContext
    func setOperationDispatchQueue(queue:DispatchQueue)->Void
    func getConfigurations() -> NSDictionary
    func setConfigurationValueForKey(value:String,key:String) -> Void
    func getConfigurationValueForKey(key:String) -> String
    func clearConfigurations()-> Void
    func removeConfigurationsValueForKey(key:String)
    func isAuthRequired() -> Bool
    
    
    //**** GET ******//
    
    func getServiceRequest(service:String, isIncludeAPIRoot:Bool,postParams:NSDictionary, isAsyncRequest:Bool,isTokenRequired:Bool,isCancelRequired:Bool,isReloadRequired:Bool,completetionHandler:@escaping (_ success:Bool,_ data:NSData)-> Void,faultHndler :@escaping (_ faultCode:Int,_ faultDetails:String,_ data:NSData)->Void,errorHandler:errorBlock)-> Void
    
    //**** POST ******//
    
    func postServiceRequest(service:String, isIncludeAPIRoot:Bool,postParams:NSDictionary, isAsyncRequest:Bool,isTokenRequired:Bool,isCancelRequired:Bool,isReloadRequired:Bool,completetionHandler:@escaping (_ success:Bool,_ data:NSData)-> Void,faultHndler :@escaping (_ faultCode:Int,_ faultDetails:String,_ data:NSData)->Void,errorHandler:errorBlock)-> Void
    
    //**** PUT ******//
    
    func putServiceRequest(service:String, isIncludeAPIRoot:Bool,postParams:NSDictionary, isAsyncRequest:Bool,isTokenRequired:Bool,isCancelRequired:Bool,isReloadRequired:Bool,completetionHandler:@escaping (_ success:Bool,_ data:NSData,_ response:AnyObject)-> Void,faultHndler :(_ faultCode:Int,_ faultDetails:String,_ data:NSData)->Void,errorHandler:errorBlock)-> Void
    
    //**** DELETE ******//
    
    func deleteServiceRequest(service:String, isIncludeAPIRoot:Bool,postParams:NSDictionary, isAsyncRequest:Bool,isTokenRequired:Bool,isCancelRequired:Bool,isReloadRequired:Bool,completetionHandler:@escaping (_ success:Bool,_ data:NSData,_ response:AnyObject)-> Void,faultHndler :@escaping (_ faultCode:Int,_ faultDetails:String,_ data:NSData)->Void,errorHandler:errorBlock)-> Void
    
    func getResource(sourcePath:String, isAsynchrounous:Bool ,isCancelRequired:Bool,isIncludeAPIRoot:Bool,completetionHandler:@escaping (_ success:Bool,_ data:NSData)-> Void,faultHndler :@escaping (_ faultCode:Int,_ faultDetails:String,_ data:NSData)->Void,errorHandler:errorBlock) -> Void
    
    
    
}
