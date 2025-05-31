//
//  Food.swift
//  HeeBob
//
//  Created by 임영택 on 5/31/25.
//

import Foundation
import SwiftData

@Model final class Food {
    @Attribute(.unique) var id: UUID
    @Attribute var title: String
    @Attribute var uniquePoint: String
    @Attribute var author: String
    @Relationship(deleteRule: .cascade) var attribute: FoodAttribute
    
    init(id: UUID, title: String, uniquePoint: String, author: String, attribute: FoodAttribute) {
        self.id = id
        self.title = title
        self.uniquePoint = uniquePoint
        self.author = author
        self.attribute = attribute
    }
}
