//
//  QuestionViewModel.swift
//  HeeBob
//
//  Created by 임영택 on 6/2/25.
//

import Foundation
import OSLog

final class QuestionViewModel: ObservableObject {
    let logger = Logger.category("QuestionViewModel")
    
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
    
    var synthesizedAnswer: UserAnswer {
        var isCookable = false
        var isPortable = false
        var mainIngredient = FoodIngredient.meat
        
        questions.forEach { question in
            switch question.id {
            case .isCookable:
                if let question = question as? Question<QuestionOption<Bool>>,
                   let answer = question.selected?.value {
                    isCookable = answer
                } else {
                    isCookable = false
                    logger.warning("isCookable 답변을 확인하는데 문제가 발생했습니다. false로 지정했습니다.")
                }
            case .isPortable:
                if let question = question as? Question<QuestionOption<Bool>>,
                   let answer = question.selected?.value {
                    isPortable = answer
                } else {
                    isPortable = false
                    logger.warning("isPortable 답변을 확인하는데 문제가 발생했습니다. false로 지정했습니다.")
                }
            case .mainIngredient:
                if let question = question as? Question<QuestionOption<FoodIngredient>>,
                   let answer = question.selected?.value {
                    mainIngredient = answer
                } else {
                    mainIngredient = .meat
                    logger.warning("mainIngredient 답변을 확인하는데 문제가 발생했습니다. meat로 지정했습니다.")
                }
            }
        }
        
        return UserAnswer(isPortable: isPortable, isCookable: isCookable, mainIngredient: mainIngredient)
    }
}

extension QuestionViewModel {    
    func selectOption(at index: Int) {
        questions[selectedIndex].select(index: index)
    }
    
    func showPreviousQuestion() {
        selectedIndex = max(0, selectedIndex - 1)
    }
    
    func showNextQuestion() {
        selectedIndex = min(questions.count - 1, selectedIndex + 1)
    }
}
