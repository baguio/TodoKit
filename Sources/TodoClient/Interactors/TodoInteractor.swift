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
    
    public func get(onCompletion: @escaping CompletionHandler<[Todo]>) -> Cancelable {
        interactor.call(.GET, "/todos",
                        onCompletion: onCompletion)
    }
    
    public func post(_ content: Todo, onCompletion: @escaping CompletionHandler<Todo>) -> Cancelable {
        interactor.call(.POST, "/todos",
                        sending: content,
                        onCompletion: onCompletion)
    }
}
