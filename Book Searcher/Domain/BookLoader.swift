//
//  BookLoader.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/11/21.
//

import Foundation

protocol BookLoader {
    func load(completion: @escaping (Result<[BookItem], Error>) -> Void)
}
