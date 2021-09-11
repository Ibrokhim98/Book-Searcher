//
//  RemoteBookLoaderTests.swift
//  Book SearcherTests
//
//  Created by Ibrokhim Shukrullaev on 9/11/21.
//

import XCTest
@testable import Book_Searcher


class RemoteBookLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let (sut, client) = makeSUT()
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
    
    // MARK: - Helpers

    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteBookLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteBookLoader(url: url, client: client)
        
        return (sut, client)
    }

    private class HTTPClientSpy: HTTPClient {
        var requestedURL: URL?
        
        func get(from url: URL) {
            requestedURL = url
        }
        
    }

}


