//
//  BookLoader.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/11/21.
//

import Foundation


enum NetworkError: Error {
   case connectivity
   case invalidData
}

protocol BookLoader {
    func load(completion: @escaping (Result<[BookItem], NetworkError>) -> Void)
}
