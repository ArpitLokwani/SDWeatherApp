//
//  NetworkServiceMock.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 17/05/17.
//  Copyright © 2017 Arpit Lokwani. All rights reserved.
//
import SystemConfiguration
import UIKit
enum environmentTypes {
    case development, production
}
class NetworkServiceMock: NetworkService {
    var serverContext: ServerContext!
    var _operationDispatchQue:DispatchQueue?
    let cookies : NSMutableDictionary! = nil
    var authEncoded:String!
    var oAuthEncoded:String!
    var activeConnections:NSMutableArray!
    let operationQueue:OperationQueue! = nil
    
    init() {
        let environment:environmentTypes = .development
        switch environment {
        case .development:
            serverContext = ServerContextDevelopment()
        case .production:
            serverContext = ServerContextProduction()
        }
    }
    
    func configureRequest(request:NSMutableURLRequest,isTokenRequired:Bool,completetionHandler: (_ request:NSMutableURLRequest)->Void) -> Void {
        let basicAuth = serverContext.basicAuth()
        request.setValue(basicAuth, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //request.setValue("IPhone", forHTTPHeaderField: "User-Agent")
        print(request)
        //        if cookies.count>0 {
        //
        //            request.addValue(self.getCookiesHeaderField(), forHTTPHeaderField: "Cookie")
        //
        //        }
        completetionHandler(request)
    }
    
    func send(request:NSMutableURLRequest,isAsynchronous:Bool,isTokenRequired:Bool,isCancelRequired:Bool,isReloadRequired:Bool,completionHandler completetionHandler:@escaping ((Bool,NSData)->Void),faultHandler:((NSInteger,String,Data)->Void)?,errorHandler:@escaping ((NSError)->Void)) -> Void {
        self.configureRequest(request: request, isTokenRequired: isTokenRequired) { (request) in
            //
            print("HTTP URL\(request.url)")
            print("HTTP HEADER FIELD\(request.allHTTPHeaderFields)")
            if isAsynchronous  {
                self.sendAsyncRequest(request: request, isCancelRequired: false, isReloadRequired: false, completionHandler: completetionHandler, faultHandler: faultHandler!, errorHandler:errorHandler)
            }else{
                self.sendSyncRequest(request: request, isCancelRequired: false, isReloadRequired: false, completionHandler: completetionHandler, faultHandler: faultHandler!, errorHandler:errorHandler)
            }
        }
    }
    
    
    // send async request
    
    func sendAsyncRequest(request:NSMutableURLRequest,isCancelRequired:Bool,isReloadRequired:Bool,completionHandler:@escaping CompletionHandler,faultHandler:@escaping (NSInteger,String,Data)->Void,errorHandler:@escaping (NSError)->Void) -> Void {
        
        if isInternetAvailable(){
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            if((error) != nil){
                print(error.debugDescription)
                print(error?.localizedDescription ?? "")
                self.operationalDipatchQueues().sync(execute: {
                    errorHandler(error as! NSError);
                } )
            }
            if((response) != nil){
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
                
                let translator = HTTPStatusTranslator().initWithStatusCode(code: httpResponse.statusCode)
                if(translator.isHTTPError())
                {
                    self.operationalDipatchQueues().sync(execute: {
                        faultHandler(translator.statusCode(),translator.statusDetails() as String,data!)
                    } )
                    return
                }
            }
            if error == nil && data != nil {
                if UIImage(data: data!) != nil {
                    completionHandler(true,data! as NSData)
                    return
                }else{
                do {
                    
                    if let jsonObject: AnyObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject {
                        if let dict = jsonObject as? NSDictionary {
                            print(dict)
                            completionHandler(true,data! as NSData)
                        }else{
                            print("not a dictionary")
                            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                            //print("this is real data \(dataString!)")
                            completionHandler(true,data! as NSData)
                        }
                    }else {
                        print("Could not parse JSON: \(error!)")
                    }
                } catch {
                    // Something went wrong
                    print("error  = \(error)")
                    errorHandler(((error as Any) as! NSError))
                }
                }
            }
            //            self.operationalDipatchQueues().sync(execute: {
            //                completionHandler(true,data! as NSData)
            //            }
            //
            //            )
        })
        task.resume()
        }else{
            postInternetConnectionLostNotification()
        }
    }
    
    // send sync request
    
    func sendSyncRequest(request:NSMutableURLRequest,isCancelRequired:Bool,isReloadRequired:Bool,completionHandler:@escaping CompletionHandler,faultHandler:@escaping (NSInteger,String,Data)->Void,errorHandler:@escaping (NSError)->Void) -> Void {
        
        if isInternetAvailable(){
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            if((response) != nil){
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
                
                let translator = HTTPStatusTranslator().initWithStatusCode(code: httpResponse.statusCode)
                if(translator.isHTTPError())
                {
                    let serialQueue = DispatchQueue(label: "seriralQueue")
                    serialQueue.sync {
                        faultHandler(translator.statusCode(),translator.statusDetails() as String,data!)
                        return ;
                        
                    }
                }
                
                //                [self.operationalDispatchQueue].sync(execute: ^{
                //                    faultHandler([translator statusCode],[translator statusDetails],data);
                //                    });
            }
            
            
            if error == nil && data != nil {
                do {
                    if let jsonObject: AnyObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject {
                        if let dict = jsonObject as? NSDictionary {
                            print(dict)
                            completionHandler(true,data! as NSData)
                        }
                        else{
                            //print("not a dictionary")
                            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                            // print("this is real data \(dataString!)")
                            completionHandler(true,data! as NSData)
                        }
                    }
                    else {
                        print("Could not parse JSON: \(error!)")
                    }
                    self.operationalDipatchQueues().sync(execute: {
                        completionHandler(true,data! as NSData)
                    }
                        
                    )
                } catch {
                    // Something went wrong
                    print("error  = \(error)")
                    errorHandler(((error as Any) as! NSError))
                }
            }
        })
        task.resume()
        }else{
            postInternetConnectionLostNotification()
        }
    }
    
    func getCookiesHeaderField() -> String {
        let cookiesValueArray =  NSMutableArray()
        for key in cookies {
            let cookieValue = cookies.object( forKey:key as AnyObject)
            if (cookieValue as AnyObject).count>0 {
                cookiesValueArray .add("\(key) = \(cookies.object( forKey: key as AnyObject))")
            }
        }
        return cookiesValueArray.componentsJoined(by: ";")
    }
    
    func getURLRequestForService(service:String,isIncludeAPIRoot:Bool,params:NSDictionary?) -> NSMutableURLRequest {
        var  urlString = self.getURLPathForService(service: service, isIncludeAPIRoot: isIncludeAPIRoot) as String
        if (params != nil) {
            if (params?.count)! > 0 {
                
            let questionMark:String = "?"
            urlString.appendingFormat(String(format: "?%@",self.parseParam(param: params!)))
            let ParamString = self.parseParam(param: params!)
            urlString = urlString+(ParamString as String)
        }
        }
        let url = NSURL(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
       

        let request = NSMutableURLRequest.init(url: url! as URL, cachePolicy:NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 30.0)
        print(request)
        return request
        
    }
    
    func parseParam(param: NSDictionary) -> NSString {
        let parseParamArray = NSMutableArray()
        for (key, value) in param {
            //parseParamArray .add("\(key)=\(value)")
            parseParamArray .add("\(key)=\(value)")
        }
        return parseParamArray .componentsJoined(by: "&") as NSString
    }
    
    func getURLPathForService(service:String,isIncludeAPIRoot:Bool) -> NSMutableString{
        
        var apiRoot = "/"
        if isIncludeAPIRoot {
            apiRoot = serverContext.api()
        }
        let urlPath =  NSMutableString(format:"%@/%@", serverContext!.domain(),apiRoot)
        if service.characters.count > 0
        {
            urlPath.append(service)
        }
        return urlPath
    }
    
    func setServerContext(context: ServerContext) ->Void {
        serverContext = context
    }
    
    func serversContext() -> ServerContext{
        return serverContext
        
    }
    
    func operationalDipatchQueues() -> DispatchQueue{
        if _operationDispatchQue == nil {
            _operationDispatchQue = DispatchQueue.global()
        }
        return _operationDispatchQue!
    }
    
    func setOperationDispatchQueue(queue: DispatchQueue) -> Void{
        _operationDispatchQue = queue
    }
    
    func isAuthRequired() -> Bool {
        return true
    }
    
    func setConfigurationValueForKey(value: String, key: String)->Void {
        if value.characters.count != 0  {
            cookies.setObject(value, forKey: key as NSCopying)
        }
    }
    
    func getConfigurationValueForKey(key: String)-> String {
        return cookies.object(forKey: key) as! String
    }
    
    func removeConfigurationsValueForKey(key: String) {
        cookies.removeObject(forKey: key)
    }
    
    func getConfigurations() -> NSDictionary {
        return cookies
    }
    
    func clearConfigurations()->Void{
        cookies .removeAllObjects()
    }
    
    //******** GET Request ******************//
    
    func getServiceRequest(service:String, isIncludeAPIRoot:Bool,postParams:NSDictionary, isAsyncRequest:Bool,isTokenRequired:Bool,isCancelRequired:Bool,isReloadRequired:Bool,completetionHandler:@escaping (_ success:Bool,_ data:NSData)-> Void,faultHndler :@escaping (_ faultCode:Int,_ faultDetails:String,_ data:NSData)->Void,errorHandler:errorBlock)-> Void
    {
        var request:NSMutableURLRequest!
        request = self.getURLRequestForService(service: service, isIncludeAPIRoot: isIncludeAPIRoot, params: postParams)
        request.httpMethod = "GET"
        self.send(request: request, isAsynchronous: true, isTokenRequired: false, isCancelRequired: false, isReloadRequired: false, completionHandler: {
            (success:Bool, data:NSData) in
            if success{
                completetionHandler(success, data)
            }
        }, faultHandler: { (faultCode:NSInteger, faultDetails:String, data:Data   ) in
            faultHndler(faultCode,faultDetails,data as NSData)
        }){
            (error:NSError) in
            print("error is \(error)")
            errorHandler!((error as Any) as! NSError)
        }
    }
    
    //******** POST Request ******************//
    
    func postServiceRequest(service:String, isIncludeAPIRoot:Bool,postParams:NSDictionary, isAsyncRequest:Bool,isTokenRequired:Bool,isCancelRequired:Bool,isReloadRequired:Bool,completetionHandler:@escaping (_ success:Bool,_ data:NSData)-> Void,faultHndler :@escaping (_ faultCode:Int,_ faultDetails:String,_ data:NSData)->Void,errorHandler:errorBlock)-> Void{
        var request:NSMutableURLRequest!
        request = self.getURLRequestForService(service: service, isIncludeAPIRoot: isIncludeAPIRoot, params: postParams)
        
        request.httpMethod = "POST"
        
        // request.HTTPBody = postData
        self.send(request: request, isAsynchronous: true, isTokenRequired: false, isCancelRequired: false, isReloadRequired: false, completionHandler: {
            (success:Bool, data:NSData) in
            if success{
                completetionHandler(success, data)
            }
        }, faultHandler: { (faultCode:NSInteger, faultDetails:String, data:Data   ) in
            faultHndler(faultCode,faultDetails,data as NSData)
        }) { (error:NSError) in
            errorHandler!((error as Any) as! NSError)
        }
    }
    
    //******** PUT Request ******************//
    
    func putServiceRequest(service:String, isIncludeAPIRoot:Bool,postParams:NSDictionary, isAsyncRequest:Bool,isTokenRequired:Bool,isCancelRequired:Bool,isReloadRequired:Bool,completetionHandler:@escaping (_ success:Bool,_ data:NSData,_ response:AnyObject)-> Void,faultHndler :(_ faultCode:Int,_ faultDetails:String,_ data:NSData)->Void,errorHandler:errorBlock)-> Void
    {
        
        var request:NSMutableURLRequest!
        request = self.getURLRequestForService(service: service, isIncludeAPIRoot: isIncludeAPIRoot, params: postParams)
        request.httpMethod = "PUT"
        
        // request.HTTPBody = postData
        self.send(request: request, isAsynchronous: true, isTokenRequired: false, isCancelRequired: false, isReloadRequired: false, completionHandler: { (success:Bool, data:NSData) in
            
            if success{
                ResponseParser().parseResponses(data: data, completetionHandler: { (success, data,response) in
                    if success{
                        completetionHandler(success, data,response)
                    }
                    else{
                        print("error")
                    }
                })
            }
        }, faultHandler: { (faultCode:NSInteger, faultDetails:String, data:Data   ) in
            //
        }) { (error:NSError) in
            errorHandler!((error as Any) as! NSError)
        }
    }
    
    //******** DELETE Request ******************//
    
    func deleteServiceRequest(service:String, isIncludeAPIRoot:Bool,postParams:NSDictionary, isAsyncRequest:Bool,isTokenRequired:Bool,isCancelRequired:Bool,isReloadRequired:Bool,completetionHandler:@escaping (_ success:Bool,_ data:NSData,_ response:AnyObject)-> Void,faultHndler :@escaping (_ faultCode:Int,_ faultDetails:String,_ data:NSData)->Void,errorHandler:errorBlock)-> Void
    {
        
        var request:NSMutableURLRequest!
        request = self.getURLRequestForService(service: service, isIncludeAPIRoot: isIncludeAPIRoot, params: postParams)
        request.httpMethod = "DELETE"
        
        // request.HTTPBody = postData
        self.send(request: request, isAsynchronous: true, isTokenRequired: false, isCancelRequired: false, isReloadRequired: false, completionHandler: { (success:Bool, data:NSData) in
            
            if success{
                ResponseParser().parseResponses(data: data, completetionHandler: { (success, data,response) in
                    if success{
                        completetionHandler(success, data,response)
                    }
                    else{
                        print("error")
                    }
                })
            }
        }, faultHandler: { (faultCode:NSInteger, faultDetails:String, data:Data   ) in
            faultHndler(faultCode,faultDetails,data as NSData)
        }) { (error:NSError) in
            errorHandler!((error as Any) as! NSError)
        }
    }
    
    func logResponse(translator:HTTPStatusTranslator, withData:Data, withError:Error) -> Void {
        
        //   if (error) errorStr = [NSString stringWithFormat:@"%@ %@", error, [error userInfo]];
        
    }
    
    
    func getResource(sourcePath:String, isAsynchrounous:Bool ,isCancelRequired:Bool,isIncludeAPIRoot:Bool,completetionHandler:@escaping (_ success:Bool,_ data:NSData)-> Void,faultHndler :@escaping (_ faultCode:Int,_ faultDetails:String,_ data:NSData)->Void,errorHandler:errorBlock) -> Void
    {
        var request:NSMutableURLRequest!
        request = self.getURLRequestForService(service: sourcePath, isIncludeAPIRoot: isIncludeAPIRoot, params: nil)
        self.send(request: request, isAsynchronous: true, isTokenRequired: false, isCancelRequired: false, isReloadRequired: false, completionHandler: { (success:Bool, data:NSData) in
            if success{
                    if success{
                        completetionHandler(success, data)
                        
                    } else{
                        print("error")
                    }
               
            }
        }, faultHandler: { (faultCode:NSInteger, faultDetails:String, data:Data   ) in
            faultHndler(faultCode,faultDetails,data as NSData)
        }) { (error:NSError) in
            errorHandler!((error as Any) as! NSError)
        }
    }
    
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Swift.Void){
        
    }
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func postInternetConnectionLostNotification() -> Void {
        let nc = NotificationCenter.default
        nc.post(name:Notification.Name(rawValue:"InternetNotification"),
                object: nil,
                userInfo: ["message":"Internet Connection Lost", "date":Date()])
    }
    
}
