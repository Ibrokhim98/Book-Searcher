//
//  RemoteBookLoader.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/11/21.
//

import Foundation

class RemoteBookLoader: BookLoader {
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load(with url: URL, completion: @escaping (Result<[BookItem], NetworkError>) -> Void) {
        client.get(from: url) { result in
            switch result {
            case  let .success((data, response)):
                if let items = try? self.map(data, response) {
                    completion(.success(items))
                } else {
                    completion(.failure(.invalidData))
                }
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
    
    func map(_ data: Data, _ response: HTTPURLResponse) throws -> [BookItem] {
        guard response.statusCode == 200 else {
            throw NetworkError.invalidData
        }
    
        var books = [BookItem]()
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
            if let items = json["items"] as? [Any] {
                for item in items {
                    var title: String?
                    var authors: [String]?
                    var thumbNail: String?
                    if let object = item as? [String: Any], let volumeInfo = object["volumeInfo"] as? [String: Any] {
                         title = volumeInfo["title"] as? String
                         authors = volumeInfo["authors"] as? [String]

                         if let imageLinks = volumeInfo["imageLinks"] as? [String: Any] {
                             thumbNail = imageLinks["thumbnail"] as? String
                         }
                     }

                    if let title = title, let authors = authors, let thumbNail = thumbNail, let url = URL(string: thumbNail) {
                        let book = BookItem(title: title, authors: authors, thumbnail: url)
                        books.append(book)
                    }
                }
            }
            
        } else {
            throw NetworkError.invalidData
        }
        
        return books
    }
}
