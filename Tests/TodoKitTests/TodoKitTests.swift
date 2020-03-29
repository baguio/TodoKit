import XCTest
import Foundation
@testable import TodoKit

final class TodoKitTests: XCTestCase {
    func testGET() {
        let semaphore = DispatchSemaphore(value: 0)
        let interactor = TodoInteractor()
        var error: Error?
        
        let cancelable = interactor.get { (result) in
            if case .failure(let incomingError) = result {
                error = incomingError
            }
            semaphore.signal()
        }
        semaphore.wait()
        XCTAssertNil(error)
    }
    
    func testPOST() {
        let semaphore = DispatchSemaphore(value: 0)
        let interactor = TodoInteractor()
        var error: Error?

        let newItem = Todo(title: "Test item")
        let cancelable = interactor.post(newItem) { (result) in
            if case .failure(let incomingError) = result {
                error = incomingError
            }
            semaphore.signal()
        }
        semaphore.wait()
        XCTAssertNil(error)
    }

    static var allTests = [
        ("testGET", testGET),
//        ("testPOST", testPOST),
    ]
}
