//
//  UserAnswerView.swift
//  HeeBob
//
//  Created by 임영택 on 6/1/25.
//

import SwiftUI

struct UserAnswerView: View {
    let userAnswer: UserAnswer
    let borderColor: Color
    let backgroundColor: Color
    
    init(userAnswer: UserAnswer, borderColor: Color = .clear, backgroundColor: Color = .hbPrimaryLighten) {
        self.userAnswer = userAnswer
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(backgroundColor)
            .strokeBorder(borderColor, lineWidth: 1)
            .frame(maxWidth: .infinity, maxHeight: 148, alignment: .topLeading)
            .overlay(
                VStack(alignment: .leading) {
                    ForEach(answerSentences.indices, id: \.self) { index in
                        if index != answerSentences.count - 1 {
                            SentenceView(content: answerSentences[index])
                                .padding(.bottom, 8)
                        } else {
                            SentenceView(content: answerSentences[index])
                        }
                    }
                }
                    .padding(24)
                    .frame(maxWidth: .infinity, alignment: .leading)
            )
    }
}

extension UserAnswerView {
    private var answerSentences: [AttributedString] {
        func ingredientToCustomString(from ingredient: FoodIngredient) -> String {
            switch ingredient {
            case .beefPork:
                return "소고기나 돼지고기"
            case .chickenAndDuck:
                return "닭고기나 오리고기"
            case .fish:
                return "생선이나 해산물"
            case .beanTofuEgg:
                return "콩 · 두부 · 계란"
            }
        }
        
        let isPortable = userAnswer.isPortable
        let isCookable = userAnswer.isCookable
        let mainIngredient = userAnswer.mainIngredient
        
        return [
            isPortable
                ? createAttributedString(fullText: "챙겨 나가야 할 메뉴에요", highlightText: "챙겨 나가야 할")
                : createAttributedString(fullText: "자리에서 먹기 좋은 메뉴에요", highlightText: "자리에서 먹기 좋은"),
            isCookable
                ? createAttributedString(fullText: "직접 준비할 수 있는 메뉴에요", highlightText: "직접 준비할 수 있는")
                : createAttributedString(fullText: "사먹기 좋은 메뉴에요", highlightText: "사먹기 좋은"),
            createAttributedString(
                fullText: "\(ingredientToCustomString(from: mainIngredient)) 메뉴에요",
                highlightText: "\(ingredientToCustomString(from: mainIngredient))"
            )
        ]
    }
    
    private func createAttributedString(fullText: String, highlightText: String) -> AttributedString {
        var string = AttributedString(fullText)
        if let range = string.range(of: highlightText) {
            string.font = .hbBody1
            string[range].font = .suite(type: .extraBold, size: 20)
        }
        return string
    }
}

fileprivate struct SentenceView: View {
    let content: AttributedString
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "checkmark")
                .renderingMode(.template)
                .foregroundStyle(Color.hbTextPrimary)
            Text(content)
                .foregroundStyle(Color.hbTextPrimary)
        }
    }
}

#Preview {
    UserAnswerView(
        userAnswer: .init(isPortable: true, isCookable: false, mainIngredient: .beefPork)
    )
    .padding()
    
    UserAnswerView(
        userAnswer: .init(isPortable: true, isCookable: false, mainIngredient: .beefPork),
        borderColor: .hbButtonSecondary,
        backgroundColor: .clear
    )
    .padding()
}
