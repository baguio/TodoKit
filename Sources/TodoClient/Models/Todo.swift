//
//  File.swift
//  
//
//  Created by everis on 3/28/20.
//

import Foundation

public struct Todo: Codable, Hashable {
    let id: UUID?
    public let title: String
}
