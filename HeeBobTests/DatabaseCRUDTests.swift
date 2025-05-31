//
//  DatabaseCRUDTests.swift
//  HeeBobTests
//
//  Created by 임영택 on 5/31/25.
//

import Testing
@testable import HeeBob
import SwiftData
import Foundation

struct DatabaseCRUDTests {
    var modelContainer: ModelContainer = {
        let modelContainer: ModelContainer
        let schema = Schema([Food.self, FoodAttribute.self, Favorite.self])
        let config = ModelConfiguration("TestModel", schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Failed to create the model container: \(error)")
        }
        return modelContainer
    }()
    
    @Test func createFoodTest() async throws {
        let context = ModelContext(modelContainer)
        
        // Given
        let id = UUID()
        let food = Food(
            id: id,
            title: "닭가슴살 샐러드",
            uniquePoint: "단백질이 풍부해요",
            author: "밥",
            attribute: FoodAttribute(
                id: id,
                isPortable: false,
                isCookable: true,
                mainIngredient: .meat
            )
        )
        
        context.insert(food)
        try context.save()
        
        // When, Then
        var descriptor = FetchDescriptor<Food>()
        descriptor.predicate = #Predicate { item in
            item.id == id
        }
        let result = try! context.fetch(descriptor)
        
        #expect(result.count == 1)
        #expect(result.first!.id == id)
        
        // Clean
        context.delete(result.first!)
    }
    
    @Test func createFavoriteTest() async throws {
        let context = ModelContext(modelContainer)
        
        // Given
        let foodId = UUID()
        let food = Food(
            id: foodId,
            title: "닭가슴살 샐러드",
            uniquePoint: "단백질이 풍부해요",
            author: "밥",
            attribute: FoodAttribute(
                id: foodId,
                isPortable: false,
                isCookable: true,
                mainIngredient: .meat
            )
        )
        
        let favoriteId = UUID()
        let favorite = Favorite(id: favoriteId, food: food, createdAt: Date())
        
        context.insert(favorite)
        try context.save()
        
        // When, Then
        var descriptor = FetchDescriptor<Favorite>()
        descriptor.predicate = #Predicate { item in
            item.id == favoriteId
        }
        let result = try! context.fetch(descriptor)
        
        #expect(result.count == 1)
        #expect(result.first!.id == favoriteId)
        
        // Clean
        context.delete(result.first!)
    }
}
