//
//  FavoriteViewModel.swift
//  HeeBob
//
//  Created by 산들 on 6/3/25.
//

import Foundation
import SwiftData

class FavoriteViewModel: ObservableObject {
    @Published var favorites: [Favorite] = []
    
    @Published var showingfavoriteSortType: FavoriteSortType? = nil
    
    @Published var isPortableUserSelected: Bool? = nil
    @Published var isCookableUserSelected: Bool? = nil
    @Published var isMainIngredientUserSelected: [FoodIngredient] = []
    
    
    var modelContext: ModelContext!
    
    func filterSelectButtonTapped(for sortType: FavoriteSortType) {
        showingfavoriteSortType = sortType
    }
    
    // MARK: - List View
    
    func listViewDidAppear(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadFavorites(where: FetchDescriptor<Favorite>())
    }
    
    func testButtonDidTap() {
        let mainIngredientRawValue = FoodIngredient.meat.rawValue
        let descriptor = FetchDescriptor<Favorite>(predicate: #Predicate { favorite in
            return favorite.food.attribute.isCookable == true
                   && favorite.food.attribute._mainIngredient == mainIngredientRawValue
        })
        
        loadFavorites(where: descriptor)
    }
    
    // MARK: - Sort Control View
    
    func portableSortTypeSelected(for value: Bool) {
        let descriptor = FetchDescriptor<Favorite>(predicate: #Predicate { favorite in
            return favorite.food.attribute.isPortable == value
        })
        loadFavorites(where: descriptor)
    }
    
    // MARK: - Core Logics
    
    private func loadFavoritesByUserSelectedOption() {
        let descriptor = FetchDescriptor<Favorite>(predicate: #Predicate { favorite in
            // TODO: isPortableUserSelected,isCookableUserSelected,isMainIngredientUserSelected를 이용해 Predicate 작성
        })
    }
    
    private func loadFavorites(where descriptor: FetchDescriptor<Favorite>) {
        do {
            favorites = try modelContext.fetch(descriptor)
        } catch {
            print("오류남 \(error)")
        }
    }
    
    enum FavoriteSortType: String, CaseIterable {
        case portable = "휴대성"
        case cookable = "식사 유형"
        case mainIngredient = "주재료"
    }
}

extension FavoriteViewModel.FavoriteSortType: Identifiable {
    var id: Self { self }
}
