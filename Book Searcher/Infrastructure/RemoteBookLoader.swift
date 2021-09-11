//
//  RemoteBookLoader.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/11/21.
//

import Foundation

class RemoteBookLoader {
    let url: URL
    let client: HTTPClient
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load() {
        client.get(from: url)
    }
}

