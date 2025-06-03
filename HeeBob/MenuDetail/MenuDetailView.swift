//
//  MenuDetailView.swift
//  HeeBob
//
//  Created by 산들 on 5/31/25.
//
//TODO: Food 엔티티 주입 후 완전 완성할 것!
import SwiftUI
import SwiftData


struct MenuDetailView: View {
    var food: Food
    @Environment(\.modelContext) private var modelContext
     
    var body: some View {
        VStack {
            MenuDetailImageBox(food: food)
            
            MenuDetailUniquePointBox(food: food)
            
            UserAnswerView(
                userAnswer: .init(isPortable: true, isCookable: false, mainIngredient: .meat),
                borderColor: .hbButtonSecondary,
                backgroundColor: .clear
            )
            .padding()
            
            MenuDetailDeleteButton(food: food)
        }
    }
}

#Preview {
    MenuDetailView(food: .init(id: UUID(uuidString: "b9fbc325-de04-48a7-805b-000000000000")!, title: "김치찌개", uniquePoint: "새콤달큰매콤", attribute: .init(id: UUID(), isPortable: true, isCookable: true, mainIngredient: .meat)))
}
