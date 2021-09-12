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
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        var capturedErrors = [Result<[BookItem], NetworkError>]()
        sut.load { capturedErrors.append($0) }
        
        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)
        
        XCTAssertEqual(capturedErrors, [.failure(.connectivity)])
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        
        var capturedErrors = [Result<[BookItem], NetworkError>]()
        sut.load { capturedErrors.append($0) }
        
        client.complete(withStatusCode: 400)
        
        XCTAssertEqual(capturedErrors, [.failure(.invalidData)])
    }
    
    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()
        
        var capturedErrors = [Result<[BookItem], NetworkError>]()
        sut.load { capturedErrors.append($0) }
        
        let invalidJSON = Data()
        client.complete(withStatusCode: 200, data: invalidJSON)
        
        XCTAssertEqual(capturedErrors, [.failure(.invalidData)])
    }
    
    func test_load_deliversNoitemsOn200HTTPResponseWithEmptyJSONList() {
        let (sut, client) = makeSUT()
        
        var capturedResults = [Result<[BookItem], NetworkError>]()
        sut.load { capturedResults.append($0) }
        
        let emptyListJSON = Data("{\"items\": []}".utf8)
        client.complete(withStatusCode: 200, data: emptyListJSON)
        
        XCTAssertEqual(capturedResults, [.success([])])
    }
    
    func test_load_deliversItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()
        
        let item1 = makeItem(title: "a title", authors: ["a author"], thumbnail: "https://a-url.com")
        
        let item2 = makeItem(title: "another title", authors: ["another author"], thumbnail: "https://another-url.com")
        
        let items = [item1.model, item2.model]
        
        var capturedResults = [Result<[BookItem], NetworkError>]()
        sut.load { capturedResults.append($0) }
        
        let json = makeItemsJSON([item1.json, item2.json])
        
        client.complete(withStatusCode: 200, data: json)
        
        XCTAssertEqual(capturedResults, [.success(items)])
    }
    
    // MARK: - Helpers

    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteBookLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteBookLoader(url: url, client: client)
        
        return (sut, client)
    }
    
    private func makeItem(title: String, authors: [String], thumbnail: String) -> (model: BookItem, json: [String : Any]) {
        let item = BookItem(title: title, authors: authors, thumbnail: thumbnail)
        let json = makeItemJSON(title, authors, thumbnail)
        return (item, json)
    }
    
    private func makeItemJSON(_ title: String, _ authors: [String], _ thumbnail: String) -> [String : Any] {
        let imageLinks = [ "smallThumbnail": "http://a-url.com", "thumbnail": thumbnail] as [String : Any]
        let volumeInfo = ["title": title, "authors": authors, "imageLinks" : imageLinks] as [String : Any]
        let item = ["kind": "a kind", "id": "an id", "etag": "etag", "selfLink": "https://a-link.com",
                    "volumeInfo" : volumeInfo] as [String : Any]
        
        return item
    }
    
    private func makeItemsJSON(_ items: [[String: Any]]) -> Data {
        let json = ["kind": "a kind", "totalItems": 100, "items" : items] as [String : Any]
        
        return try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }

    private class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (Result<HTTPClientResponse, Error>) -> Void)]()
        
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (Result<HTTPClientResponse, Error>) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, data: Data = Data(), at index: Int = 0) {
            let response = HTTPURLResponse(url: messages[index].url,
                                           statusCode: code,
                                           httpVersion: nil,
                                           headerFields: nil)!
            
            messages[index].completion(.success((data, response)))
        }
        
    }

}


