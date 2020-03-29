//
//  File.swift
//  
//
//  Created by everis on 3/28/20.
//

import Foundation

public final class Todo: Codable {
    let id: UUID?
    public let title: String
    
    public init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
