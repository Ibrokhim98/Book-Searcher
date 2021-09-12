//
//  SearchViewModel.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/12/21.
//

import Foundation

protocol SearchViewDelegate: AnyObject {
    func renderView()
}

class SearchViewModel {
    private let loadUseCase: LoadBooksUseCase
    private var books: [BookItem] = []
    
    weak var delegate: SearchViewDelegate?
    
    init(loadUseCase: LoadBooksUseCase) {
        self.loadUseCase = loadUseCase
    }
    
    func loadBooks(with query: String) {
        loadUseCase.loadBooks(with: query) { [weak self] result in
            switch result {
            case .success(let books):
                self?.books = books
                self?.delegate?.renderView()
            case .failure(_):
                //TODO: Handle error
                break
            }
        }
    }
    
    var booksCount: Int {
        set {
            if newValue == 0 {
                books = []
            }
        }
        get {
            books.count
        }
    }
    
    func getTitle(at index: Int) -> String {
        return books[index].title
    }
    
    func getAuthorsList(at index: Int) -> [String] {
        return books[index].authors
    }
    
    func getThumnail(at index: Int) -> URL {
        return books[index].thumbnail
    }
}
