//
//  RemoteBookLoader.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/11/21.
//

import Foundation

enum NetworkError: Error {
   case connectivity
   case invalidData
}

class RemoteBookLoader {
    let url: URL
    let client: HTTPClient
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
   func load(completion: @escaping (Result<[BookItem], NetworkError>) -> Void) {
        client.get(from: url) { result in
            switch result {
            case  let .success((data, _)):
                if let _ =  try? JSONSerialization.jsonObject(with: data) {
                    completion(.success([]))
                } else {
                    completion(.failure(.invalidData))
                }
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}

