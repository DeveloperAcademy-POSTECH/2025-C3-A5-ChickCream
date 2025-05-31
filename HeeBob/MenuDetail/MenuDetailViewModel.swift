//
//  MenuDetailViewModel.swift
//  HeeBob
//
//  Created by 산들 on 5/31/25.
//

import SwiftUI


//뷰모델
class MenuDetailViewModel: ObservableObject {
    @Published var description: [AttributedString] = []
    
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

//TODO: 뷰모델, 익스텐션으로 고민
var descriptions: [AttributedString] {
    return [
        isPortable ? makeHighlightedComment(fullText: "챙겨 다니기 편해요!", highlightText: "챙겨 다니기") : makeHighlightedComment(fullText: "집에서 먹는 것을 추천해요!", highlightText: "집에서"),
        isCookable ? makeHighlightedComment(fullText: "직접 요리해 먹기 좋아요!", highlightText: "직접 요리해") : makeHighlightedComment(fullText: "외식으로 먹는 것을 추천해요!", highlightText: "외식으로"),
        makeHighlightedComment(fullText: "\(mainIngredient.getDescription())으로 만들어 든든해요!", highlightText: "\(mainIngredient.getDescription())"),
    ]
}
