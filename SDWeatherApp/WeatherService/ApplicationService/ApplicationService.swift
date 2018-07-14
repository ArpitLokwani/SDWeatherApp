//
//  ApplicationService.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 17/05/17.
//  Copyright © 2017 Arpit Lokwani. All rights reserved.
//

import Foundation

protocol ApplicationService{
    func setConfiguration(value:AnyObject, forKey key:AnyObject) -> Void
    func getConfigurationValueForKey(key :AnyObject) -> AnyObject
    func getConfigurations() -> NSMutableDictionary
    func removeConfigurationValueForKey (key : AnyObject) -> Void
    func clearConfiguration()
    func saveConfiguration() throws
    func loadConfiguration(completionHandler: (_ succes: Bool) -> Void) throws
    func addSkipBackupAttributeToItemAtURL(url: NSURL) throws
}
