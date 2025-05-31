//
//  Favorite.swift
//  HeeBob
//
//  Created by 임영택 on 5/31/25.
//

import Foundation
import SwiftData

@Model final class Favorite {
    @Attribute(.unique) var id: UUID
    @Relationship(deleteRule: .cascade) var food: Food
    @Attribute var createdAt: Date
    
    init(id: UUID, food: Food, createdAt: Date) {
        self.id = id
        self.food = food
        self.createdAt = createdAt
    }
}
