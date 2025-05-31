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
    var mainIngredient: FoodIngredient {
        get {
            .init(rawValue: _mainIngredient) ?? .egg
        }
        
        set {
            _mainIngredient = newValue.rawValue
        }
    }
    @Attribute var _mainIngredient: Int // see: https://stackoverflow.com/a/79294430
    
    init(id: UUID, isPortable: Bool, isCookable: Bool, mainIngredient: FoodIngredient) {
        self.id = id
        self.isPortable = isPortable
        self.isCookable = isCookable
        self._mainIngredient = mainIngredient.rawValue
    }
    
    enum FoodIngredient: Int, Codable {
        case meat = 1
        case fish = 2
        case egg = 3
        case tofu = 4
    }
}
