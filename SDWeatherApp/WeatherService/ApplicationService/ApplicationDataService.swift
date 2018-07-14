//
//  ApplicationDataService.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 17/05/17.
//  Copyright © 2017 Arpit Lokwani. All rights reserved.
//

import Foundation

class ApplicaitonDataService: ApplicationService {
    var model:ApplicationData? = ApplicationData.sharedInstance
    
    class var sharedInstance: ApplicaitonDataService {
        struct Static {
            static var instance: ApplicaitonDataService? = nil
        }
        return Static.instance!
    }
    
    func loadConfiguration(completionHandler: (_ succes: Bool) -> Void) throws {
        if (model!.configuarionFilePath != nil) {
            let  configurations  = NSMutableDictionary(contentsOf: model!.configuarionFilePath as URL)
            model?.configuration = NSMutableDictionary()
            if configurations!.count>0 {
                model?.configuration = configurations!
                try! self.saveConfiguration()
                completionHandler(true)
            }else{
                completionHandler(false)
            }
        }else{
            completionHandler(false)
        }
    }
    
    func addSkipBackupAttributeToItemAtURL(url: NSURL) throws{
        assert(FileManager.default.fileExists(atPath: url.path!))
        try url.setResourceValue(true, forKey: URLResourceKey.isExcludedFromBackupKey)
    }

    func saveConfiguration() throws{
        model?.configuration.write(to: model!.configuarionFilePath! as URL, atomically: true)
        try self.addSkipBackupAttributeToItemAtURL(url: model!.configuarionFilePath!)
    }
    
    func getConfigurationValueForKey(key: AnyObject) -> AnyObject {
        if ObjectUtils.getObjectFrom(dictionary: (model?.configuration)!, Key: key )!.length>0{
            return ObjectUtils.getObjectFrom(dictionary: (model?.configuration)!, Key: key )!
        }else
        {
            return "" as AnyObject
        }
    }
    
    func getConfigurations() -> NSMutableDictionary {
        return (model?.configuration)!
    }
    func removeConfigurationValueForKey(key: AnyObject) -> Void{
        return (model?.configuration .removeObject(forKey: key ))!
    }
    
    func clearConfiguration() {
        model?.configuration.removeAllObjects()
    }
    func setConfiguration(value: AnyObject, forKey key: AnyObject) ->Void {
        //        if value.count>0 && key.count>0{
        model?.configuration.setValue(value, forKey: key as! String)
        
        //        }
    }
}
