//
//  UsersClient.swift
//  iOS API
//
//  Created by Thomas Eisenbeis on 8/30/18.
//  Copyright © 2018 CoPilot Creative. All rights reserved.
//

import Foundation

class UsersClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func getUsers(from feedType: UsersFeed, completion: @escaping (Result<[UsersResultFeed]?, APIError>) -> Void) {
        
        let endpoint = feedType
        let request = endpoint.request
        
        request.httpMethod = "GET"
        
        fetch(with: request as URLRequest, decode: { json -> [UsersResultFeed]? in
            guard let feedResult = json as? [UsersResultFeed] else { return  nil }
            return feedResult
        }, completion: completion)
    }
    
    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func getUser(from feedType: UsersFeed, userID: Int64, completion: @escaping (Result<User?, APIError>) -> Void) {
        
        var endpoint = feedType
        endpoint.userID = userID
        let request = endpoint.request
        
        request.httpMethod = "GET"
        
        fetch(with: request as URLRequest, decode: { json -> User? in
            guard let feedResult = json as? User else { return  nil }
            return feedResult
        }, completion: completion)
    }
    
    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func addUser(from feedType: UsersFeed, firstName: String, lastName: String, email: String, completion: @escaping (Result<BlankFeedResult?, APIError>) -> Void) {
        
        let endpoint = feedType
        let request = endpoint.request
        
        request.httpMethod = "POST"
        var dataObject = Dictionary<String, Any>()
        dataObject["firstName"] = firstName
        dataObject["lastName"] = lastName
        dataObject["email"] = email
        request.httpBody = try? JSONSerialization.data( withJSONObject: dataObject, options: [])
        
        fetch(with: request as URLRequest, decode: { json -> BlankFeedResult? in
            guard let feedResult = json as? BlankFeedResult else { return  nil }
            return feedResult
        }, completion: completion)
    }
}

