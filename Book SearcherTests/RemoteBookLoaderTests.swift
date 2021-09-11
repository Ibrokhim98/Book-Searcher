//
//  RemoteBookLoaderTests.swift
//  Book SearcherTests
//
//  Created by Ibrokhim Shukrullaev on 9/11/21.
//

import XCTest
@testable import Book_Searcher

class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
    
}

class RemoteBookLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        let url = URL(string: "https://a-url.com")!
        _ = RemoteBookLoader(url: url, client: client)
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClientSpy()
        let url = URL(string: "https://another-url.com")!
        let sut = RemoteBookLoader(url: url, client: client)
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
}
