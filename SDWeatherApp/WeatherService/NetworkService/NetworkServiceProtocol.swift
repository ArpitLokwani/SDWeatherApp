//
//  NetworkServiceProtocol.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 22/05/17.
//  Copyright © 2017 Arpit Lokwani. All rights reserved.
//

import UIKit

class NetworkServiceProtocol: URLProtocol, URLSessionDataDelegate, URLSessionTaskDelegate {
    private var dataTask: URLSessionDataTask?
    private var urlResponse: URLResponse?
    private var receivedData: NSMutableData?
    
    class var CustomHeaderSet: String {
        return "CustomHeaderSet"
    }
    
    // MARK: NSURLProtocolNetworkServiceProtocol
    
    override class func canInit(with request: URLRequest) -> Bool {
        guard let host = request.url?.host, host == "spencer.com" else {
            return false
        }
        if (URLProtocol.property(forKey: NetworkServiceProtocol.CustomHeaderSet, in: request as URLRequest) != nil) {
            return false
        }
        
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        let mutableRequest =  NSMutableURLRequest.init(url: self.request.url!, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 240.0)//self.request as! NSMutableURLRequest
        
        //Add User Agent
        let userAgentValueString = "cache-age"
        mutableRequest.setValue(userAgentValueString, forHTTPHeaderField: "User-Agent")
        mutableRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        print(mutableRequest.allHTTPHeaderFields ?? "")
        URLProtocol.setProperty("true", forKey: NetworkServiceProtocol.CustomHeaderSet, in: mutableRequest)
        let defaultConfigObj = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: defaultConfigObj, delegate: self, delegateQueue: nil)
        self.dataTask = defaultSession.dataTask(with: mutableRequest as URLRequest)
        self.dataTask!.resume()
        
    }
    
    override func stopLoading() {
        self.dataTask?.cancel()
        self.dataTask       = nil
        self.receivedData   = nil
        self.urlResponse    = nil
    }
    
    // MARK: NSURLSessionDataDelegate
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask,
                    didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        self.urlResponse = response
        self.receivedData = NSMutableData()
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.client?.urlProtocol(self, didLoad: data as Data)
        
        self.receivedData?.append(data as Data)
    }
    
    // MARK: NSURLSessionTaskDelegate
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil { //&& error.code != NSURLErrorCancelled {
            self.client?.urlProtocol(self, didFailWithError: error!)
        } else {
            saveCachedResponse()
            self.client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    // MARK: Private methods
    
    /**
     Do whatever with the data here
     */
    func saveCachedResponse () {
        let timeStamp = NSDate()
        let dataString = NSString(data: self.receivedData! as Data, encoding: String.Encoding.utf8.rawValue) as NSString?
        print("TimeStamp:\(timeStamp)\n\nDATA:\(dataString)\n\n")
    }

    
}
