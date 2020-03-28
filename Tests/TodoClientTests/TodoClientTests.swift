import XCTest
@testable import TodoClient

final class TodoClientTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(TodoClient().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
