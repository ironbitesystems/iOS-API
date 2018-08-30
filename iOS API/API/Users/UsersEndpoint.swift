//
//  UsersEndpoint.swift
//  iOS API
//
//  Created by Thomas Eisenbeis on 8/30/18.
//  Copyright © 2018 CoPilot Creative. All rights reserved.
//

import Foundation

enum UsersFeed {
    
    case getUsers
    case getUser
    case addUser
}

extension UsersFeed: Endpoint {
    
    var path: URL {
        switch self {
        case .getUsers:
            return (base.appendingPathComponent("users", isDirectory:false))!
        case .getUser:
            return (base.appendingPathComponent("users", isDirectory: false)?.appendingPathComponent("\(userID)", isDirectory:false))!
        default:
            return (base.appendingPathComponent("users", isDirectory: false)?.appendingPathComponent("add", isDirectory:false))!
        }
    }
    
}

