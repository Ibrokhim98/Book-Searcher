//
//  HTTPClient.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/11/21.
//

import Foundation

protocol HTTPClient {
    func get(from url: URL, completion: @escaping (Error) -> Void)
}
