import XCTest
@testable import HttpSwift

class HttpSwiftTests: XCTestCase {

    func testGetRequestWithoutHandler() {
        HTTP.instance.get(url: "http://httpbin.org/get").do()
    }

    func testGetRequest() {
        let expectation = self.expectation(description: "get request test")

        HTTP.instance
            .get(url: "http://httpbin.org/get").do { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 30, handler: nil)
    }

    func testCustomHeader() {

        let expectation = self.expectation(description: "custom header request test")

        HTTP.instance
            .get(url: "http://httpbin.org/headers")
            .setHeader(headers: ["key1": "1", "key2": "2"]).do { result in
                switch result {
                case .success(let response):
                    print(response)
                case .failure(let error):
                    print(error)
                }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 30, handler: nil)
    }

    static var allTests = [
        ("testGetRequest", testGetRequest),
        ("testCustomHeader", testCustomHeader),
    ]
}
