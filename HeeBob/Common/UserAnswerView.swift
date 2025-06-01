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
        let isPortable = userAnswer.isPortable
        let isCookable = userAnswer.isCookable
        let mainIngredient = userAnswer.mainIngredient
        
        return [
            isPortable
                ? createAttributedString(fullText: "휴대하기 편한 메뉴면 좋겠어요", highlightText: "휴대하기 편한")
                : createAttributedString(fullText: "휴대하기 어려운 메뉴도 괜찮아요", highlightText: "휴대하기 어려운"),
            isCookable
                ? createAttributedString(fullText: "직접 조리할래요", highlightText: "직접 조리")
                : createAttributedString(fullText: "배달이나 외식이 좋아요", highlightText: "배달이나 외식"),
            createAttributedString(
                fullText: "주재료가 \(mainIngredient.localizedName)인 음식이 좋아요",
                highlightText: "주재료가 \(mainIngredient.localizedName)인"
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
            Text(content)
        }
    }
}

#Preview {
    UserAnswerView(
        userAnswer: .init(isPortable: true, isCookable: false, mainIngredient: .meat)
    )
    .padding()
    
    UserAnswerView(
        userAnswer: .init(isPortable: true, isCookable: false, mainIngredient: .meat),
        borderColor: .hbButtonSecondary,
        backgroundColor: .clear
    )
    .padding()
}
