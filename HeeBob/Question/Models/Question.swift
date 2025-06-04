//
//  Question.swift
//  HeeBob
//
//  Created by 임영택 on 6/2/25.
//

import Foundation

protocol AnyQuestion {
    var id: QuestionId { get }
    var title: String { get }
    var subTitle: String? { get }
    var titleTopPadding: CGFloat? { get }
    var options: [String] { get }
    var selectedOptionIndex: Int? { get }
    mutating func select(index: Int)
}

protocol AnyOption: Hashable {
    var title: String { get }
}

struct Question<Option: AnyOption>: AnyQuestion {
    let id: QuestionId
    let title: String
    let subTitle: String?
    let titleTopPadding: CGFloat?
    var options: [String] {
        return optionsWithType.map { "\($0)" }
    }
    var selectedOptionIndex: Int? {
        if let selected = selected {
            return optionsWithType.firstIndex(where: { $0 == selected })
        }
        
        return nil
    }
    
    let optionsWithType: [Option]
    var selected: Option?
    
    mutating func select(index: Int) {
        selected = optionsWithType[index]
    }
}

enum QuestionId: Hashable {
    case isPortable
    case isCookable
    case mainIngredient
}

struct QuestionOption<Value: Hashable>: AnyOption, CustomStringConvertible {
    let title: String
    let value: Value
    
    var description: String {
        return title
    }
}
