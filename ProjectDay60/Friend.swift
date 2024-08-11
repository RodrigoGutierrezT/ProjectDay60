//
//  Friend.swift
//  ProjectDay60
//
//  Created by Rodrigo on 10-08-24.
//

import SwiftData
import Foundation

@Model
class Friend: Identifiable, Codable, Hashable {
    
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case _name = "name"

    }
    
    let id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let stringId = try container.decode(String.self, forKey: ._id)
        self.id = UUID(uuidString: stringId)!
        self.name = try container.decode(String.self, forKey: ._name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id.description, forKey: ._id)
    }
}
