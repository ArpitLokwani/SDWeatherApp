//
//  ALlias.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 4/4/17.
//  Copyright © 2017 Arpit Lokwani. All rights reserved.
//

import Foundation

//Handler Blocks
typealias CompletionHandler = (Bool, NSData)->(Void)?
typealias completionHandlerBlk = (_ success:Bool,_ data:NSData,_ response:AnyObject)->Void
typealias boolDictionaryStringErrorBlock = (_ success:Bool?,_ response:Dictionary<String, Any>?,_ output:NSString?,_ error:NSError?) -> Void
typealias notification = ((_ motification:NSNotification) -> Void)?
typealias arrayBlock  = ((_ array:NSArray) -> Void)?
typealias errorBlock = ((_ error:NSError) -> Void)?
typealias boolBlock  = ((_ success:Bool) -> Void)?
typealias integerBlock=((_ intValue:NSInteger) -> Void)?
typealias dataBlock = ((_ data:NSData) -> Void)?
typealias voidBlock = ((Void) -> Void)?
typealias boolArrayBlock = ((_ success:Bool,_ array:NSArray) -> Void)?
typealias boolErrorStringBlock = ((_ succes:Bool,_ value:String,_ stringValue:NSString) ->Void)?
typealias boolDictinaryBlock = ((_ success:Bool,NSDictionary) -> Void)?
typealias arrayErrorBlock = ((NSArray,NSError) -> Void)?
typealias dictionaryErrorBlock = ((NSDictionary,NSError) -> Void)?
typealias dataErrorBlock = ((NSData,NSError) -> Void)?

