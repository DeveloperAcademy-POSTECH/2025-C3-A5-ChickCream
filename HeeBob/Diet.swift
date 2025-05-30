//
//  Diet.swift
//  HeeBob
//
//  Created by 임영택 on 5/30/25.
//

import Foundation

struct Diet: Identifiable, Decodable {
    let id: UUID
    let title: String
    let isPortable: Bool
    let isCookable: Bool
    let mainIngredient: String
    let author: String
}
