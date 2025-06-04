//
//  MenuDetailView.swift
//  HeeBob
//
//  Created by 산들 on 5/31/25.
//
import SwiftUI
import SwiftData


struct MenuDetailView: View {
    var food: Food
    
    @EnvironmentObject var router: NavigationRouter
    
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
    MenuDetailView(food: .init(id: UUID(uuidString: "b9fbc325-de04-48a7-805b-000000000000")!, title: "김치찌개", uniquePoint: "새콤달큰매콤새콤달큰매콤새콤달큰매콤새콤달큰매콤새콤달큰매콤새콤달큰매콤새콤달큰", attribute: .init(id: UUID(), isPortable: true, isCookable: true, mainIngredient: .meat)))
}
