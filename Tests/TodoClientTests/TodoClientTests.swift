import XCTest
import Foundation
@testable import TodoClient

final class TodoClientTests: XCTestCase {
    func testExample() {
        let semaphore = DispatchSemaphore(value: 0)
        print("loading")
        let interactor = TodoInteractor()
        
        let cancelable2 = interactor.get { (result) in
            if case .success(let todoList) = result {
                print(todoList)
            } else {
                print("error")
            }
            semaphore.signal()
        }
        semaphore.wait()
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
