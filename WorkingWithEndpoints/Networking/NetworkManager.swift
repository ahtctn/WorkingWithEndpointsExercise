//
//  NetworkManager.swift
//  WorkingWithEndpoints
//
//  Created by Ahmet Ali ÇETİN on 19.07.2023.
//

import Foundation

typealias NetworkResult<T> = Result<T, NetworkError>
typealias NetworkCompletion<T> = (NetworkResult<T>) -> Void

typealias UserCompletion = (Result<UserArray, NetworkError>) -> Void
typealias CommentsCompletion = (Result<CommentsArray, NetworkError>) -> Void
typealias AlbumsCompletion = (Result<AlbumsArray, NetworkError>) -> Void
typealias TodosCompletion = (Result<TodosArray, NetworkError>) -> Void
typealias PostsCompletion = (Result<PostsModel, NetworkError>) -> Void


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
    
    func getUser(completion: @escaping UserCompletion) {
        let endpoint = Endpoint.getUsers
        request(endpoint, completion: completion)
    }
    
    func getComments(postId: String, completion: @escaping CommentsCompletion) {
        let endpoint = Endpoint.getComments(postID: postId)
        request(endpoint, completion: completion)
    }
    
    func getAlbums(completion: @escaping AlbumsCompletion) {
        let endpoint = Endpoint.getAlbums
        request(endpoint, completion: completion)
    }
    
    func getTodos(completion: @escaping TodosCompletion) {
        let endpoint = Endpoint.getTodos
        request(endpoint, completion: completion)
    }
    
    func posts(title: String, body: String, userId: Int, completion: @escaping PostsCompletion) {
        let endpoint = Endpoint.posts(title: title, body: body, userId: userId)
        request(endpoint, completion: completion)
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingError( _ error: Error)
}
