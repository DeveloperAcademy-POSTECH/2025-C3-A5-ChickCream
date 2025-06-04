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
    func portableSortTypeSelected(for value: Bool?) {
        if let value = value {
            let descriptor = FetchDescriptor<Favorite>(predicate: #Predicate { favorite in
                favorite.food.attribute.isPortable == value
            })
            loadFavorites(where: descriptor)
        } else {
            // predicate 없이 전체 fetch
            let descriptor = FetchDescriptor<Favorite>()
            loadFavorites(where: descriptor)
        }
    }
    
    func cookableSortTypeSelected(for value: Bool?) {
        if let value = value {
            let descriptor = FetchDescriptor<Favorite>(predicate: #Predicate { favorite in
                favorite.food.attribute.isCookable == value
            })
            loadFavorites(where: descriptor)
        } else {
            // predicate 없이 전체 fetch
            let descriptor = FetchDescriptor<Favorite>()
            loadFavorites(where: descriptor)
        }
    }
    
    func mainIngredientSortTypeSelected(for value: Int?) {
        if let value = value {
            let descriptor = FetchDescriptor<Favorite>(predicate: #Predicate { favorite in
                favorite.food.attribute._mainIngredient == value
            })
            loadFavorites(where: descriptor)
        } else {
            // predicate 없이 전체 fetch
            let descriptor = FetchDescriptor<Favorite>()
            loadFavorites(where: descriptor)
        }
    }
    
    // MARK: - Core Logics
    
//    private func loadFavoritesByUserSelectedOption() {
//        let descriptor = FetchDescriptor<Favorite>(predicate: #Predicate { favorite in
//            // TODO: isPortableUserSelected,isCookableUserSelected,isMainIngredientUserSelected를 이용해 Predicate 작성
//        })
//    }
    private func loadFavoritesByUserSelectedOption() {
        let portableFilter = isPortableUserSelected
        let cookableFilter = isCookableUserSelected
        let mainIngredients = isMainIngredientUserSelected.map { $0.rawValue }
        
        let predicate = #Predicate<Favorite> { favorite in
            // 휴대성 필터 조건 (옵셔널 처리)
            (portableFilter == nil || favorite.food.attribute.isPortable == portableFilter!) &&
            // 조리 가능 여부 필터 조건 (옵셔널 처리)
            (cookableFilter == nil || favorite.food.attribute.isCookable == cookableFilter!) &&
            // 주재료 필터 조건 (배열이 비어있지 않은 경우만 적용)
            (mainIngredients.isEmpty || mainIngredients.contains(favorite.food.attribute._mainIngredient))
        }
        
        let descriptor = FetchDescriptor<Favorite>(predicate: predicate)
        loadFavorites(where: descriptor)
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
