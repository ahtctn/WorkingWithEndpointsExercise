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
    var parameters: [String: Any]? { get }
    
    func request() -> URLRequest
}

enum Endpoint {
    case getUsers
    case getComments(postID: String)
    case getAlbums
    case getTodos
    case posts(title: String, body: String, userId: Int)
        
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
        case .getAlbums:
            return Constants.path_albums
        case .getTodos:
            return Constants.path_todos
        case .posts:
            return Constants.parameters_posts
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        case .getComments:
            return .get
        case .getAlbums:
            return .get
        case .getTodos:
            return .get
        case .posts:
            return .post
        }
    }
    
    var headers: [String : String]? {
        
        if case .posts = self {
            let header: [String: String]? = ["Content-type" : "application/json; charset=UTF-8"]
            return header
        }
        
        return nil
    }
    
    var parameters: [String: Any]? {
        if case .posts(let title, let body, let userId) = self {
            return ["title": title, "body": body, "userId": userId]
        }
        
        return nil
    }
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else {
            fatalError("Component error")
        }
        
        if case .getComments(let id) = self {
            components.queryItems = [URLQueryItem(name: "posts", value: id)]
        }
        
        components.path = path
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        if let parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
                request.httpBody = data
            } catch {
                print("\(error.localizedDescription) JSONSerialization Error.")
            }
        }
        
        
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

