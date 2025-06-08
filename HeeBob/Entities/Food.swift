//
//  Food.swift
//  HeeBob
//
//  Created by 임영택 on 5/31/25.
//

import Foundation
import SwiftData

@Model final class Food {
    #Index<Food>([\.title])
    
    @Attribute(.unique) var id: UUID
    @Attribute var title: String
    @Attribute var uniquePoint: String
    @Relationship(deleteRule: .cascade) var attribute: FoodAttribute
    
    init(id: UUID, title: String, uniquePoint: String, attribute: FoodAttribute) {
        self.id = id
        self.title = title
        self.uniquePoint = uniquePoint
        self.attribute = attribute
    }
}
