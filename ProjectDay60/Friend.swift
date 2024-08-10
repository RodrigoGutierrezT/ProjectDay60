//
//  Friend.swift
//  ProjectDay60
//
//  Created by Rodrigo on 10-08-24.
//

import Foundation

struct Friend: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
}
