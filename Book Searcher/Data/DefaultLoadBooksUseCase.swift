//
//  DefaultLoadBooksUseCase.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/12/21.
//

import Foundation

final class DefaultLoadBooksUseCase: LoadBooksUseCase {
    private let bookLoader: BookLoader
    private var baseURL = "https://www.googleapis.com/books/v1/volumes?q="
    
    init(bookLoader: BookLoader) {
        self.bookLoader = bookLoader
    }
    
    func loadBooks(with query: String, completion: @escaping (Result<[BookItem], AppError>) -> Void) {
        guard !query.isEmpty, let url = URL(string: baseURL + query) else {
            completion(.failure(.emptyQuery))
            return
        }
        
        bookLoader.load(with: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let books):
                    completion(.success(books))
                case .failure(let error):
                    completion(.failure(.network(error)))
                }
            }
        }
    }
    
    
}
