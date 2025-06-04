//
//  ResultsViewModel.swift
//  HeeBob
//
//  Created by BoMin Lee on 6/4/25.
//

import SwiftUI
import SwiftData

final class ResultsViewModel: ObservableObject {
    @Published var carouselItems: [CarouselItem] = []
    
    var modelContext: ModelContext
    let userAnswer: UserAnswer
    private var fetchedFoodIDs: Set<UUID> = []  // 이미 추천된 음식 추적용
    
    init(userAnswer: UserAnswer) {
        self.userAnswer = userAnswer
        loadInitialRecommendations()
    }
    
    func resultViewDidLoad(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func loadInitialRecommendations() {
        do {
            let foods = try fetchMatchingFoods(limit: 3)
            fetchedFoodIDs.formUnion(foods.map { $0.id })
            updateCarouselItems(with: foods)
        } catch {
            print("❌ Initial fetch failed: \(error)")
            self.carouselItems = [.addCard]
        }
    }
    
    func loadOneMoreRecommendation() {
        do {
            let newFoods = try fetchMatchingFoods(limit: 1, excluding: fetchedFoodIDs)
            guard let food = newFoods.first else { return }
            fetchedFoodIDs.insert(food.id)
            insertFoodBeforeAddCard(food)
        } catch {
            print("❌ Failed to load one more food: \(error)")
        }
    }
    
    private func fetchMatchingFoods(limit: Int, excluding excludedIDs: Set<UUID> = []) throws -> [Food] {
        let portableAnswer = userAnswer.isPortable
        let cookableAnswer = userAnswer.isCookable
        let mainIngredientAnswer = userAnswer.mainIngredient.rawValue
        
        let descriptor = FetchDescriptor<Food>(
            predicate: #Predicate { food in
                food.attribute.isPortable == portableAnswer &&
                food.attribute.isCookable == cookableAnswer &&
                food.attribute._mainIngredient == mainIngredientAnswer &&
                !excludedIDs.contains(food.id)
            }
        )
        let matchingFoods = try modelContext.fetch(descriptor)
        return Array(matchingFoods.shuffled().prefix(limit))
    }

    private func updateCarouselItems(with foods: [Food]) {
        self.carouselItems = foods.map { .food($0) } + [.addCard]
    }
    
    private func insertFoodBeforeAddCard(_ food: Food) {
        let index = max(carouselItems.count - 1, 0)
        carouselItems.insert(.food(food), at: index)
    }
}
