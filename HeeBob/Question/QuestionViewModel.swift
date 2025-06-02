//
//  QuestionViewModel.swift
//  HeeBob
//
//  Created by 임영택 on 6/2/25.
//

import Foundation

final class QuestionViewModel: ObservableObject {
    @Published private(set) var questions: [AnyQuestion] = [
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
    
    @Published var selectedIndex = 0
    
    var selectedQuestion: AnyQuestion {
        questions[selectedIndex]
    }
}

extension QuestionViewModel {
    func previousButtonTapped() {
        showPreviousQuestion()
    }
    
    private func showPreviousQuestion() {
        selectedIndex = max(0, selectedIndex - 1)
    }
    
    func nextButtonTapped() {
        showNextQuestion()
    }
    
    private func showNextQuestion() {
        selectedIndex = min(questions.count - 1, selectedIndex + 1)
    }
    
    func selectOption(at index: Int) {
        questions[selectedIndex].select(index: index)
    }
}
