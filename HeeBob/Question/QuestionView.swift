//
//  QuestionView.swift
//  HeeBob
//
//  Created by 임영택 on 6/1/25.
//

import SwiftUI

struct QuestionView: View {
    /// TODO: move to ViewModel
    static let questions: [AnyQuestion] = [
        Question(
            id: .isPortable,
            title: "휴대성이\n필요하신가요?",
            optionsWithType: [
                QuestionOption(title: "네", value: true),
                QuestionOption(title: "아니오", value: false),
            ]
        ),
        Question(
            id: .isCookable,
            title: "배달이나 외식 어때요?",
            optionsWithType: [
                QuestionOption(title: "좋아요", value: true),
                QuestionOption(title: "직접\n조리할래요", value: false),
            ]
        ),
        Question(
            id: .mainIngredient,
            title: "어떤 재료가 좋을까요?",
            optionsWithType: [
                QuestionOption(title: "육고기", value: FoodIngredient.meat),
                QuestionOption(title: "수산물", value: FoodIngredient.fish),
                QuestionOption(title: "달걀", value: FoodIngredient.egg),
                QuestionOption(title: "두부", value: FoodIngredient.tofu),
            ]
        ),
    ]
    
    @State var selectedQuestion = questions[0]
    var selectedIndex: Int {
        QuestionView.questions.firstIndex { $0.id == selectedQuestion.id } ?? 0
    }
    
    var body: some View {
        VStack {
            QuestionIndicatorView(lastPage: QuestionView.questions.count, currentPage: selectedIndex + 1)
                .padding(.top, 23)
            
            Spacer()
            
            QuestionTitleView(selectedQuestion.title)
            
            Spacer()
            
            if selectedQuestion.options.count == 2 {
                HStack(spacing: 16) {
                    ForEach(selectedQuestion.options.indices, id: \.self) { index in
                        QuestionOptionButton(title: selectedQuestion.options[index], type: .half, isDisabled: selectedQuestion.selectedOptionIndex != index) {
                            selectedQuestion.select(index: index)
                        }
                    }
                }
                .padding(.bottom, 204)
            } else if selectedQuestion.options.count == 4 {
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        ForEach(selectedQuestion.options.indices[0..<2], id: \.self) { index in
                            QuestionOptionButton(title: selectedQuestion.options[index], type: .quarter, isDisabled: selectedQuestion.selectedOptionIndex != index) {
                                selectedQuestion.select(index: index)
                            }
                        }
                    }
                    
                    HStack(spacing: 16) {
                        ForEach(selectedQuestion.options.indices[2..<4], id: \.self) { index in
                            QuestionOptionButton(title: selectedQuestion.options[index], type: .quarter, isDisabled: selectedQuestion.selectedOptionIndex != index) {
                                selectedQuestion.select(index: index)
                            }
                        }
                    }
                }
                .padding(.bottom, 128)
            } else {
                Text("렌더링할 수 없습니다")
            }
            
            HStack {
                HBButton(configuration: .init(title: "이전", imageName: "chevron.left", imageType: .system, imagePosition: .left, foregroundColor: .hbPrimary, backgroundColor: .hbPrimaryLighten, disabled: selectedIndex == 0)) {
                    showPreviousQuestion()
                }
                
                HBButton(configuration: .init(title: selectedIndex == QuestionView.questions.count - 1 ? "결과 보기" : "다음", imageName: "chevron.right", imageType: .system, imagePosition: .right, disabled: selectedQuestion.selectedOptionIndex == nil)) {
                    showNextQuestion()
                }
            }
        }
    }
}

extension QuestionView {
    private func showPreviousQuestion() {
        selectedQuestion = QuestionView.questions[max(0, selectedIndex - 1)]
    }
    
    private func showNextQuestion() {
        selectedQuestion = QuestionView.questions[min(QuestionView.questions.count - 1, selectedIndex + 1)]
    }
}

struct QuestionTitleView: View {
    let content: String
    
    init(_ content: String) {
        self.content = content
    }
    
    var body: some View {
        Text(content)
            .font(.hbTitle)
            .foregroundStyle(Color.hbTextPrimary)
            .multilineTextAlignment(.center)
    }
}

struct QuestionOptionButton: View {
    let title: String
    let type: QuestionOptionButtonType
    let isDisabled: Bool
    let didTap: () -> Void
    
    var body: some View {
        Button {
            didTap()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(isDisabled ? Color.clear : Color.hbPrimaryLighten)
                    .stroke(isDisabled ? Color.hbDisabled : Color.hbPrimary, style: .init(lineWidth: 3))
                    .frame(width: 173, height: type == .half ? 160 : 144 )
                
                Text(title)
                    .font(.hbSubtitle)
                    .foregroundStyle(isDisabled ? Color.hbDisabled : Color.hbPrimary)
            }
        }

    }
    
    enum QuestionOptionButtonType {
        case half
        case quarter
    }
}

#Preview {
    QuestionView()
}
