//
//  APIClient.swift
//  iOS API
//
//  Created by Thomas Eisenbeis on 5/21/18.
//  Copyright © 2018 CoPilot Creative. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}

/* Setup error response for API call */
enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case response200
    case response404
    case response401
    case response500
    case response201
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .response200: return "Success"
        case .response201: return "Accepted submission"
        case .response401: return "Not authorized"
        case .response404: return "Record not found"
        case .response500: return "Server Error"
        }
    }
}

protocol APIClient {
    
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
    
}

extension APIClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                
                if let json = data {
                    
                    do {
                        
                        let genericModel = try JSONDecoder().decode(decodingType, from: json)
                        
                        completion(genericModel, nil)
                        
                    } catch {
                        
                        print(error)
                        
                        completion(nil, .jsonConversionFailure)
                        
                    }
                    
                } else {
                    
                    completion(nil, .invalidData)
                    
                }
                
            } else {
                
                
                switch httpResponse.statusCode {
                    
                /*
                     add your message based on status code
                     Make sure to add your response code to enum APIError
                */
                    
                case 200:
                    completion(nil, .response200)
                    break
                case 201:
                    completion(nil, .response201)
                    break
                case 401:
                    completion(nil, .response401)
                    break
                case 404:
                    completion(nil, .response404)
                    break
                case 500:
                    completion(nil, .response500)
                    break
                default:
                    completion(nil, .responseUnsuccessful)
                    break
                    
                }
                
            }
            
        }
        
        return task
        
    }
    
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
            
            //MARK: change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                // Decode json and check
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
}
