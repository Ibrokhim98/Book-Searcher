//
//  BookItem.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/11/21.
//

import Foundation

struct BookItem: Equatable {
    let title: String
    let authors: [String]
    let description: String
    let thumbnail: URL
}
