import XCTest
@testable import HttpSwift

class HttpSwiftTests: XCTestCase {
    
    func testGetRequestWithoutHandler() {
        HTTP.instance.get(url: "http://httpbin.org/get").do()
    }
    
    func testGetRequest() {
        HTTP.instance
            .get(url: "http://httpbin.org/get").do { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func testCustomHeader() {
        HTTP.instance
            .get(url: "http://httpbin.org/headers")
            .setHeader(headers: ["key1": "1", "key2": "2"]).do { result in
                switch result {
                case .success(let response):
                    print(response)
                case .failure(let error):
                    print(error)
                }
        }
    }

    static var allTests = [
        ("testGetRequest", testGetRequest),
    ]
}
