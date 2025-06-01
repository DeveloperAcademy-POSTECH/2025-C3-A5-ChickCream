//
//  FoodIngredient.swift
//  HeeBob
//
//  Created by 임영택 on 6/1/25.
//

import Foundation

enum FoodIngredient: Int, Codable {
    case meat = 1
    case fish
    case egg
    case tofu
    
    var localizedName: String {
        switch self {
        case .meat: "육고기"
        case .fish: "수산물"
        case .tofu: "두부"
        case .egg: "달걀"
        }
    }
    
    static func fromLocalizedName(_ localizedName: String) -> FoodIngredient? {
        switch localizedName {
        case "육고기": .meat
        case "수산물": .fish
        case "두부": .tofu
        case "달걀": .egg
        default : nil
        }
    }
}
