//
//  ServiceContext.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 17/05/17.
//  Copyright © 2017 Arpit Lokwani. All rights reserved.
//

import UIKit

class ServiceContext: NSObject {
    
    var classDictionary:NSMutableDictionary?
    var objectDictionary:NSMutableDictionary?
    
    override init() {
        let path = Bundle.main.path(forResource: "ALServices", ofType: "plist")
        classDictionary = NSMutableDictionary.init(contentsOfFile: path!)
        objectDictionary = NSMutableDictionary.init(capacity: classDictionary!.count)
    }
    
    func getBundle() -> Bundle {
        return Bundle.main
    }
    
    
    
}
