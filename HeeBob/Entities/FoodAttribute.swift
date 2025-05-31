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
    
    var descriptions: [AttributedString] {
        return [
            isPortable ? makeHighlightedComment(fullText: "챙겨 다니기 편해요!", highlightText: "챙겨 다니기") : makeHighlightedComment(fullText: "집에서 먹는 것을 추천해요!", highlightText: "집에서"),
            isCookable ? makeHighlightedComment(fullText: "직접 요리해 먹기 좋아요!", highlightText: "직접 요리해") : makeHighlightedComment(fullText: "외식으로 먹는 것을 추천해요!", highlightText: "외식으로"),
            makeHighlightedComment(fullText: "\(mainIngredient.getDescription())으로 만들어 든든해요!", highlightText: "\(mainIngredient.getDescription())"),
        ]
    }
    // fullText에 "전체 메시지 중 강조하고 싶은 메시지", highlightText에 "강조"를 넣는 함수
    func makeHighlightedComment(fullText: String, highlightText: String) -> AttributedString {
        var string = AttributedString(fullText)
        if let range = string.range(of: highlightText) {
            string.font = .hbBody1
            string[range].font = .hbBody1.weight(.bold)
        }
        return string
    }
}
