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
    
    var descriptions: [String] {
        return [
            isPortable ? "휴대성이 간편해요" : "휴대못해흥",
            isCookable ? "소화성" : "",
            "\(mainIngredient.getDescription())이 들어갔어요",
        ]
    }
    
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
        
        func getDescription() -> String {
            switch self {
            case .meat:
                return "살림"
            case .fish:
                return "생선"
            case .egg:
                return "계란"
            case .tofu:
                return "두부"
            }
        }
    }
}
