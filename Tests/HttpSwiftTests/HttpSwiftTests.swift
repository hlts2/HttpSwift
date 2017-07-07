import XCTest
@testable import HttpSwift

class HttpSwiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(HttpSwift().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
