//
//  File.swift
//  
//
//  Created by everis on 3/28/20.
//

import Foundation

public typealias SimpleResult<T> = Result <T, Swift.Error>
public typealias CompletionHandler<T> = (SimpleResult<T>) -> Void

public protocol Cancelable {
    func cancel()
}

extension URLSessionDataTask: Cancelable {}

class CancelableGroup: Cancelable {
    private let items: [Cancelable]
    init(_ items: [Cancelable]) {
        self.items = items
    }
    func cancel() {
        items.forEach { $0.cancel() }
    }
}

public extension Cancelable {
    static func group(_ items: Cancelable...) -> Cancelable {
        CancelableGroup(items)
    }
}

enum HttpMethod: String {
    case GET, POST, DELETE, UPDATE
}

extension URL {
    init(TODOfrom string: String) {
        self.init(string: "http://localhost:8080" + string)!
    }
}
