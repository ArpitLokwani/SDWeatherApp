//
//  StringUtils.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 19/05/17.
//  Copyright © 2017 Arpit Lokwani. All rights reserved.
//

import UIKit

/*
 +(NSString *)getFileNameWithoutExtension:(NSString *)filePath{
 NSArray *parts = [filePath componentsSeparatedByString:@"/"];
 if (parts.count <= 1) {
 return filePath;
 }
 NSString *fileNameWithExtension = (NSString *)[parts lastObject];
 return [[fileNameWithExtension componentsSeparatedByString:@"."] objectAtIndex:0];
 }
 
 +(NSString *)getFileTypeFromPath:(NSString *)filePath{
 NSArray *parts = [filePath componentsSeparatedByString:@"."];
 if (parts.count <= 1) {
 return @"";
 }
 return (NSString *)[parts lastObject];
 }

 */
class StringUtils: NSObject {

    class func getFileNameWithoutExtension(filePath:String) -> String{
        let parts = filePath.components(separatedBy: "") as NSArray
        if parts.count <= 1 {
            return filePath
        }
        let fileNameWithExtension = parts.lastObject! as! String
        return fileNameWithExtension.components(separatedBy: ".")[0]
    }
    
    
    class func getFileTypeFromPath(filePath:String) -> String
    {
        let parts:NSArray = filePath.components(separatedBy: ".") as NSArray
        if parts.count<=1 {
            return ""
        }
        return parts.lastObject as! String
    }
    
}
