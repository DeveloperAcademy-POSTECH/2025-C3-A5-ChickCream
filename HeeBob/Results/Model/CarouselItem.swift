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

    var id: UUID {
        switch self {
        case .food(let food):
            return food.id
        case .addCard:
            return UUID(uuidString: "00000000-0000-0000-0000-000000000001")!
        }
    }
}
