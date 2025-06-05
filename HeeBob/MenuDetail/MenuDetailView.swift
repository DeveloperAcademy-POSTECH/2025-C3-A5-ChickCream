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
    @Environment(\.modelContext) var modelContext
    @State var relatedFavorite: Favorite?
    
    var body: some View {
        
        VStack {
            MenuDetailImageBox(food: food)
            
            MenuDetailUniquePointBox(food: food)
            
            UserAnswerView(
                userAnswer: .init(isPortable: true, isCookable: false, mainIngredient: .beefPork),
                borderColor: .hbButtonSecondary,
                backgroundColor: .clear
            )
            .padding()
            
            if let relatedFavorite = relatedFavorite {
                MenuDetailDeleteButton(favorite: relatedFavorite)
            }
        }
        .onAppear {
            viewDidAppear()
        }
    }
}

extension MenuDetailView {
    func viewDidAppear() {
        loadFavorite()
    }
    
    private func loadFavorite() {
        let foodId = food.id
        let descriptor = FetchDescriptor<Favorite>(predicate: #Predicate { favorite in
            return favorite.food.id == foodId
        })
        
        do {
            relatedFavorite = try modelContext.fetch(descriptor).first
        } catch {
            print("오류남 \(error)")
        }
    }
}

#Preview {
    MenuDetailView(food: .init(id: UUID(uuidString: "b9fbc325-de04-48a7-805b-000000000000")!, title: "김치찌개", uniquePoint: "새콤달큰매콤새콤달큰매콤새콤달큰매콤새콤달큰매콤새콤달큰매콤새콤달큰매콤새콤달큰", attribute: .init(id: UUID(), isPortable: true, isCookable: true, mainIngredient: .beefPork)))
}
