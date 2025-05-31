//
//  Result.swift
//  HeeBob
//
//  Created by BoMin Lee on 5/31/25.
//

import SwiftUI

struct ResultModel: Identifiable {
    var id: UUID = .init()
    var image: String
}

var results: [ResultModel] = (1...3).compactMap({ ResultModel(image: "Sample \($0)")})
