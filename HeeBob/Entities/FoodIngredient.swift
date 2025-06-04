//
//  FoodIngredient.swift
//  HeeBob
//
//  Created by 임영택 on 6/1/25.
//

import Foundation

enum FoodIngredient: Int, Codable, Hashable {
    case beefPork = 1
    case chickenAndDuck
    case fish
    case beanTofuEgg
    
    var localizedName: String {
        switch self {
        case .beefPork: "소고기/돼지고기"
        case .chickenAndDuck: "닭고기/오리고기"
        case .fish: "생선/해산물"
        case .beanTofuEgg: "콩·두부·계란"
        }
    }
    
    static func fromLocalizedName(_ localizedName: String) -> FoodIngredient? {
        switch localizedName {
        case "소고기/돼지고기": .beefPork
        case "닭고기/오리고기": .chickenAndDuck
        case "생선/해산물": .fish
        case "콩·두부·계란": .beanTofuEgg
        default : nil
        }
    }
}
