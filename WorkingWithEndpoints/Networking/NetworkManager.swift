//
//  NetworkManager.swift
//  WorkingWithEndpoints
//
//  Created by Ahmet Ali ÇETİN on 19.07.2023.
//

import Foundation

typealias NetworkResult<T> = Result<T, NetworkError>
typealias NetworkCompletion<T> = (NetworkResult<T>) -> Void

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init(){}
    
    private func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping NetworkCompletion<T>) {
        
        let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200,
                  response.statusCode <= 299 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
                
            } catch {
                print(error.localizedDescription)
                completion(.failure(NetworkError.decodingError(error)))
            }
        }
        task.resume()
        
    }
    
    func getUser(completion: @escaping (Result<UserArray, NetworkError>) -> Void) {
        let endpoint = Endpoint.getUsers
        request(endpoint, completion: completion)
    }
    
    func getComments(completion: @escaping (Result<CommentsArray, NetworkError>) -> Void) {
        let endpoint = Endpoint.getComments
        request(endpoint, completion: completion)
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingError( _ error: Error)
}
