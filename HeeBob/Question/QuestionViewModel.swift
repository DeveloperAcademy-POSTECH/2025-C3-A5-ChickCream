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
            title: "식사를 챙겨 나가야 하나요?",
            subTitle: "챙겨 나갈 메뉴는 휴대가\n간편한 음식으로 추천해드려요.",
            titleTopPadding: 104,
            optionsWithType: [
                QuestionOption(title: "네", value: true),
                QuestionOption(title: "아니오", value: false),
            ]
        ),
        Question(
            id: .isCookable,
            title: "식사를 직접 준비할\n여유가 있으신가요?",
            subTitle: "여유가 없으시다면, 사 드시기 편한\n메뉴로 추천해드릴게요.",
            titleTopPadding: 84,
            optionsWithType: [
                QuestionOption(title: "좋아요", value: true),
                QuestionOption(title: "직접\n조리할래요", value: false),
            ]
        ),
        Question(
            id: .mainIngredient,
            title: "어떤 재료가 좋을까요?",
            subTitle: nil,
            titleTopPadding: nil,
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
    
    var finalAnswer: UserAnswer? {
        guard selectedIndex == questions.count - 1 else {
            return nil
        }
        
        var isCookable = false
        var isPortable = false
        var mainIngredient = FoodIngredient.meat
        
        for question in questions {
            switch question.id {
            case .isCookable:
                if let question = question as? Question<QuestionOption<Bool>>,
                   let answer = question.selected?.value {
                    isCookable = answer
                } else {
                    logger.warning("isCookable 답변을 확인하는데 문제가 발생했습니다.")
                    return nil
                }
            case .isPortable:
                if let question = question as? Question<QuestionOption<Bool>>,
                   let answer = question.selected?.value {
                    isPortable = answer
                } else {
                    logger.warning("isPortable 답변을 확인하는데 문제가 발생했습니다.")
                    return nil
                }
            case .mainIngredient:
                if let question = question as? Question<QuestionOption<FoodIngredient>>,
                   let answer = question.selected?.value {
                    mainIngredient = answer
                } else {
                    logger.warning("mainIngredient 답변을 확인하는데 문제가 발생했습니다.")
                    return nil
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
