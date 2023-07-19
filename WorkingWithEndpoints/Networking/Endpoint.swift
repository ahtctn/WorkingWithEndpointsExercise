//
//  Endpoint.swift
//  WorkingWithEndpoints
//
//  Created by Ahmet Ali ÇETİN on 19.07.2023.
//

import Foundation

//https://jsonplaceholder.typicode.com/users

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    
    func request() -> URLRequest
}

enum Endpoint {
    case getUsers
    case getComments
        
}

extension Endpoint: EndpointProtocol {
    var baseURL: String {
        return Constants.baseURL
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return Constants.path_users
        case .getComments:
            return Constants.path_comments
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        case .getComments:
            return .get
        }
    }
    
    var headers: [String : String]? {
        //let header: [String: String]? = ["Authorization" : "Bearer: \(token)"]
        return nil
    }
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else {
            fatalError("Component error")
        }
        
        components.path = path
        
        var request = URLRequest(url: components.url!)
        
        request.httpMethod = method.rawValue
        
        if let header = headers {
            for (key, value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
        
        
    }
    
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

