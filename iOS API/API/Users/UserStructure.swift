//
//  UserStructure.swift
//  iOS API
//
//  Created by Thomas Eisenbeis on 5/21/18.
//  Copyright © 2018 Ironbite Systems. All rights reserved.
//

import Foundation

struct UsersResultFeed: Codable {
    
    let userList: [User]
    let status: Bool?
    let error: String?
    
}

struct User {
    
    var id: Int64?
    var firstName: String?
    var lastName: String?
    var email: String?
    
    enum CodingKeys: CodingKey {
        case id
        case firstName
        case lastName
        case email
    }
    
}

extension User: Encodable {
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        if let value = id {
            
            try container.encode(value, forKey: .id)
        }
        
        if let value = firstName {
            
            try container.encode(value, forKey: .firstName)
            
        }
        
        if let value = lastName {
            
            try container.encode(value, forKey: .lastName)
            
        }
        
        if let value = email {
            
            try container.encode(value, forKey: .email)
            
        }
        
    }
    
}

extension User: Decodable {
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let value = try? values.decode(Int64.self, forKey: .id) {
            
            id = value
        }
        
        if let value = try? values.decode(String.self, forKey: .firstName) {
            
            firstName = value
        }
        
        if let value = try? values.decode(String.self, forKey: .lastName) {
            
            lastName = value
        }
        
        if let value = try? values.decode(String.self, forKey: .email) {
            
            email = value
        }
        
    }
    
}
