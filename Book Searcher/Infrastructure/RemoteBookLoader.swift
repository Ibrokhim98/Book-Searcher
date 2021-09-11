//
//  RemoteBookLoader.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/11/21.
//

import Foundation

enum NetWorkError: Error {
   case connectivity
}

class RemoteBookLoader {
    let url: URL
    let client: HTTPClient
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load(completion: @escaping (NetWorkError) -> Void) {
        client.get(from: url) { error in
            completion(.connectivity)
        }
    }
}

