//
//  RawDataEntry.swift
//  HeeBob
//
//  Created by 임영택 on 5/31/25.
//

import Foundation

struct RawDataEntry: Decodable {
    let id: UUID
    let title: String
    let uniquePoint: String
    let attribute: RawDataAttribute
    let author: String // not used
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case uniquePoint
        case attribute = "attributes"
        case author
    }
    
    func toEntity() -> Food {
        return Food(
            id: id,
            title: title,
            uniquePoint: uniquePoint,
            attribute: FoodAttribute(
                id: id,
                isPortable: attribute.isPortable,
                isCookable: attribute.isCookable,
                mainIngredient: FoodIngredient.fromLocalizedName(attribute.mainIngredient) ?? .beefPork
            )
        )
    }
    
    struct RawDataAttribute: Decodable {
        let isPortable: Bool
        let isCookable: Bool
        let mainIngredient: String
    }
}
