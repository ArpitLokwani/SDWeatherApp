//
//  WeatherService.swift
//  SDWeatherApp
//
//  Created by Arpit Lokwani on 7/13/18.
//  Copyright © 2018 SD. All rights reserved.
//

import UIKit

class WeatherService: NSObject {

    var netwokService : AnyObject? = nil
    var servicefact = ServiceFactory()
    var remoteServiceFact = RemoteServiceFactory()
    let error:NSError? = nil
    var postParams :[String:String] = [
        "" : ""
    ]
    
    
    //GET WEATHER REPORT
    func getWeatherReport(place:String,completetionHandler:@escaping boolDictionaryStringErrorBlock,errorHandler:errorBlock)  -> Void {
        let bannerService = NSString(format: "%@",remoteServiceFact.cartServices())
       // logActivity(message: bannerService as String)
        let postParam :[String:String] = [
            "q" : place,
            "appid" : Constant.appID,
        ]
        servicefact.networkServices().getServiceRequest(service: bannerService as String, isIncludeAPIRoot: true
            , postParams: postParam as NSDictionary, isAsyncRequest: true, isTokenRequired: false, isCancelRequired: false, isReloadRequired: false, completetionHandler: { (success, data) in
                if success{
                    ResponseParser().parseResponses(data: data, completetionHandler: { (success, data,response) in
                        if success{
                            completetionHandler(true,response as? Dictionary<String, Any>,nil,nil)
                        }else{
                            print("error")
                        }
                    })
                }
        },faultHndler: { (faultCode, faultDetails, data) in
            do{
                let output = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
                var failureMessage = "Bad Request"
                
                failureMessage = "city not found"
                completetionHandler(false,nil,failureMessage as NSString,nil)
            }
            catch{
            }
            print(faultDetails)
        }){ (error) in
            errorHandler!((error as Any) as! NSError)
        }
    }
}
