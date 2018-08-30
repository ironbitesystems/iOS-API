//
//  EndPoint.swift
//  iOS API
//
//  Created by Thomas Eisenbeis on 8/29/18.
//  Copyright © 2018 CoPilot Creative. All rights reserved.
//

import Foundation

/* Add necessary variables for calls that require URL variables */

struct RequestVars {
    
    static var userIDs: Array<Int64> = Array<Int64>()
    static var deviceToken: String = ""
    static var userID: Int64 = 0
    
}

/* Create variables necessary for call */

protocol Endpoint {
    
    var base: NSURL { get }
    var path: URL { get }
    var userIDs: Array<Int64> { get set }
    var deviceToken: String { get set }
    var userID: Int64 { get set }
}

/* Setup up get and set of variables */

extension Endpoint {
    
    var userID: Int64 {
        get {
            return RequestVars.userID
        }
        set(ID) {
            RequestVars.userID = ID
        }
    }
    
    var userIDs: Array<Int64> {
        get {
            return RequestVars.userIDs
        }
        set(IDArray) {
            RequestVars.userIDs = IDArray
        }
    }
    
    var deviceToken: String {
        get {
            return RequestVars.deviceToken
        }
        set(token) {
            RequestVars.deviceToken = token
        }
    }
    
    /* Enter your api key */
    var apiKey: String {
        return "xxxxxx"
    }
    
    /* Enter url for API */
    var base: NSURL {
        return NSURL( string: "https://www.url.com/api" )!
    }
    
    var request: NSMutableURLRequest {
        let urlRequest = NSMutableURLRequest(url: path as URL)
        urlRequest.setValue(apiKey, forHTTPHeaderField: "X-Api-Key") // Make sure to enter API Header key
        return urlRequest
    }
}
