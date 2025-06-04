//
//  CarouselItem.swift
//  HeeBob
//
//  Created by BoMin Lee on 6/1/25.
//

import Foundation

enum CarouselItem: Identifiable {
    case food(Food)
    case addCard

    var id: String {
        switch self {
        case .food(let food):
            return food.id.uuidString
        case .addCard:
            return "addCard"
        }
    }
}
