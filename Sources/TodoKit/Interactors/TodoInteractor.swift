//
//  File.swift
//  
//
//  Created by everis on 3/28/20.
//

import Foundation

enum TodoError: Error {
    case invalidResponse
}

public class TodoInteractor {
    private let interactor = Interactor()
    public init() {}
    
    public func get(onCompletion: @escaping CompletionHandler<[Todo]>) -> Cancelable {
        interactor.call(.GET, "/todos",
                        onCompletion: onCompletion)
    }
    
    public func post(_ content: Todo, onCompletion: @escaping CompletionHandler<Todo>) -> Cancelable {
        interactor.call(.POST, "/todos",
                        sending: content,
                        onCompletion: onCompletion)
    }
    
    public func delete(byID todoID: UUID, onCompletion: @escaping CompletionHandler<Todo>) -> Cancelable {
        interactor.call(.POST, "/todos",
                        sending: TodoDeleteRequest(todoID: todoID),
                        onCompletion: onCompletion)
    }
}

extension TodoInteractor {
    public func delete(_ todo: Todo, onCompletion: @escaping CompletionHandler<Todo>) -> Cancelable? {
        if let todoID = todo.id {
            return self.delete(byID: todoID, onCompletion: onCompletion)
        } else {
            return nil
        }
    }
}

struct TodoDeleteRequest: Codable {
    let todoID: UUID
}
