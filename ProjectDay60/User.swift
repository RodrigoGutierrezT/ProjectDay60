//
//  User.swift
//  ProjectDay60
//
//  Created by Rodrigo on 10-08-24.
//

import SwiftData
import Foundation

@Model
class User: Identifiable, Codable, Hashable {
    
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case _isActive = "isActive"
        case _name = "name"
        case _age = "age"
        case _company = "company"
        case _email = "email"
        case _address = "address"
        case _about = "about"
        case _registered = "registered"
        case _tags = "tags"
        case _friends = "friends"
    }
    
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
    
    init(id: UUID, isActive: Bool, name: String, age: Int, company: String, email: String, address: String, about: String, registered: Date, tags: [String], friends: [Friend]) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let stringId = try container.decode(String.self, forKey: ._id)
        self.id = UUID(uuidString: stringId)!
        self.isActive = try container.decode(Bool.self, forKey: ._isActive)
        self.name = try container.decode(String.self, forKey: ._name)
        self.age = try container.decode(Int.self, forKey: ._age)
        self.company = try container.decode(String.self, forKey: ._company)
        self.email = try container.decode(String.self, forKey: ._email)
        self.address = try container.decode(String.self, forKey: ._address)
        self.about = try container.decode(String.self, forKey: ._about)
        let stringDate = try container.decode(String.self, forKey: ._registered)
        self.registered = ISO8601DateFormatter().date(from: stringDate)!
        self.tags = try container.decode([String].self, forKey: ._tags)
        self.friends = try container.decode([Friend].self, forKey: ._friends)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id.description, forKey: ._id)
        try container.encode(self.isActive, forKey: ._isActive)
        try container.encode(self.name, forKey: ._name)
        try container.encode(self.age, forKey: ._age)
        try container.encode(self.company, forKey: ._company)
        try container.encode(self.email, forKey: ._email)
        try container.encode(self.address, forKey: ._address)
        try container.encode(self.about, forKey: ._about)
        try container.encode(ISO8601DateFormatter().string(from: registered), forKey: ._registered)
        try container.encode(self.tags, forKey: ._tags)
        try container.encode(self.friends, forKey: ._friends)
    }
}
