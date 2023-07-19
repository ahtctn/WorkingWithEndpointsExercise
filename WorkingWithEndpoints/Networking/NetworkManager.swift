//
//  NetworkManager.swift
//  WorkingWithEndpoints
//
//  Created by Ahmet Ali ÇETİN on 19.07.2023.
//

import Foundation

class NetworkManager {
    func request(_ endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode <= 299 else {
                print(error)
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {
                print(error)
                completion(.failure(error!))
                return
            }
            
            do {
                let decoder = try? JSONDecoder()
                
                let decodedData = decoder?.decode(Data.self, from: data)
                
                
            } catch {
                
            }
            
            
        }
    }
}
