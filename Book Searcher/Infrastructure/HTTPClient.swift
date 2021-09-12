//
//  HTTPClient.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/11/21.
//

import Foundation

public typealias HTTPClientResponse = (Data, HTTPURLResponse)

protocol HTTPClient {
    func get(from url: URL, completion: @escaping (Result<HTTPClientResponse, Error>) -> Void)
}

final class HTTPClientRepository: HTTPClient {
    
    func get(from url: URL, completion: @escaping (Result<HTTPClientResponse, Error>) -> Void) {
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            completion(.success((data, response)))
        }
        task.resume()
    }
}
