//
//  User.swift
//  ProjectDay60
//
//  Created by Rodrigo on 10-08-24.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    let registered: Date
    var tags: [String]
    var friends: [Friend]
}
