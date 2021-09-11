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
