//
//  ApplicationData.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 17/05/17.
//  Copyright © 2017 Arpit Lokwani. All rights reserved.
//

import UIKit

class ApplicationData: NSObject {
    
    var configuration :NSMutableDictionary = [:]
    var configuarionFilePath:NSURL!
    
    class var sharedInstance: ApplicationData {
        struct Static {
            static var instance: ApplicationData? = ApplicationData()
        }
        return Static.instance!
    }
    
}

