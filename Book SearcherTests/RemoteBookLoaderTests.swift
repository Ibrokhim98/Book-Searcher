//
//  RemoteBookLoaderTests.swift
//  Book SearcherTests
//
//  Created by Ibrokhim Shukrullaev on 9/11/21.
//

import XCTest

class RemoteBookLoader {
    
}

class HTTPClient {
    var requestedURL: URL?
}

class RemoteBookLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        _ = RemoteBookLoader()
        
        XCTAssertNil(client.requestedURL)
    }
}
