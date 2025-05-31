//
//  FoodAttribute.swift
//  HeeBob
//
//  Created by 임영택 on 5/31/25.
//

import Foundation
import SwiftData

@Model final class FoodAttribute {
    @Attribute(.unique) var id: UUID // should be equal to Food entity's id
    @Attribute var isPortable: Bool
    @Attribute var isCookable: Bool
    @Attribute var mainIngredient: FoodIngredient
    
    init(id: UUID, isPortable: Bool, isCookable: Bool, mainIngredient: FoodIngredient) {
        self.id = id
        self.isPortable = isPortable
        self.isCookable = isCookable
        self.mainIngredient = mainIngredient
    }
    
    enum FoodIngredient: Codable {
        case meat
        case fish
        case egg
        case tofu
    }
}
