//
//  LoadBooksUseCase.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/12/21.
//

import Foundation

enum AppError: Error {
    case network(NetworkError)
    case emptyQuery
}

protocol LoadBooksUseCase {
    func loadBooks(with query: String, completion: @escaping (Result<[BookItem], AppError>) -> Void)
}
