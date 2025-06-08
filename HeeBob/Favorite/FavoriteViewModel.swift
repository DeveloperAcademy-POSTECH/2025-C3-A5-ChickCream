//
//  FavoriteViewModel.swift
//  HeeBob
//
//  Created by 산들 on 6/3/25.
//

import Foundation
import SwiftData
import SwiftUICore

class FavoriteViewModel: ObservableObject {
    @Published var favorites: [Favorite] = []
    
    @Published var showingfavoriteSortType: FavoriteSortType? = nil
    
    @Published var isPortableUserSelected: Bool? = nil
    @Published var userSelectedColor: [Color] = []
    @Published var isCookableUserSelected: Bool? = nil
    @Published var mainIngredientsUserSelected: [FoodIngredient] = []

    // !에서 옵셔널로 변경
    var modelContext: ModelContext?
    
    func filterSelectButtonTapped(for sortType: FavoriteSortType) {
        showingfavoriteSortType = sortType
    }
    
    // MARK: - List View
    
    func listViewDidAppear(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadFavorites(where: FetchDescriptor<Favorite>())
    }
    
    func testButtonDidTap() {
        let mainIngredientRawValue = FoodIngredient.beefPork.rawValue
        let descriptor = FetchDescriptor<Favorite>(predicate: #Predicate { favorite in
            return favorite.food.attribute.isCookable == true
                   && favorite.food.attribute._mainIngredient == mainIngredientRawValue
        })
        loadFavorites(where: descriptor)
    }
    
    // MARK: - Sort Control View
    func portableSortTypeSelected(for value: Bool?) {
        isPortableUserSelected = value
        loadFavoritesByUserSelectedOption()
    }
    
    func cookableSortTypeSelected(for value: Bool?) {
        isCookableUserSelected = value
        loadFavoritesByUserSelectedOption()
    }

    // 메인 재료 필터링 메서드 개선
    func mainIngredientSortTypeSelected(for ingredients: [FoodIngredient]) {
        mainIngredientsUserSelected = ingredients
        loadFavoritesByUserSelectedOption()
    }

    
    // MARK: - Core Logics
    
    func loadFavoritesByUserSelectedOption() {
        let portableFilter = isPortableUserSelected
        let cookableFilter = isCookableUserSelected
        let mainIngredients = mainIngredientsUserSelected.map { $0.rawValue }

        // MARK: - Predicate 외부에서 조건을 미리 계산합니다.
                // portableFilter가 nil이면 모든 항목을 포함하고, 아니면 선택된 portableValue와 일치하는 항목만 포함합니다.
                let portablePredicateExpression: Bool?
                if let portableValue = portableFilter {
                    portablePredicateExpression = portableValue
                } else {
                    portablePredicateExpression = nil // nil이면 Predicate에서 해당 조건을 무시하도록 할 것임
                }

                // cookableFilter도 동일하게 처리합니다.
                let cookablePredicateExpression: Bool?
                if let cookableValue = cookableFilter {
                    cookablePredicateExpression = cookableValue
                } else {
                    cookablePredicateExpression = nil // nil이면 Predicate에서 해당 조건을 무시하도록 할 것임
                }

                let predicate = #Predicate<Favorite> { favorite in
                    // portablePredicateExpression이 nil이 아니면, 해당 조건과 favorite.food.attribute.isPortable를 비교합니다.
                    // nil이면 true를 반환하여 이 조건을 무시합니다.
                    (portablePredicateExpression == nil || favorite.food.attribute.isPortable == portablePredicateExpression!) &&
                    // cookablePredicateExpression이 nil이 아니면, 해당 조건과 favorite.food.attribute.isCookable를 비교합니다.
                    // nil이면 true를 반환하여 이 조건을 무시합니다.
                    (cookablePredicateExpression == nil || favorite.food.attribute.isCookable == cookablePredicateExpression!) &&
                    // mainIngredients가 비어있으면 true를 반환하여 이 조건을 무시합니다.
                    (mainIngredients.isEmpty || mainIngredients.contains(favorite.food.attribute._mainIngredient))
                }
                let descriptor = FetchDescriptor<Favorite>(predicate: predicate)
                loadFavorites(where: descriptor)
        
    }
    //
    //        let predicate = #Predicate<Favorite> { favorite in
    //            // 휴대성 필터 조건 (옵셔널 처리)
    //            (portableFilter == nil || favorite.food.attribute.isPortable == portableFilter!) &&
    //            // 조리 가능 여부 필터 조건 (옵셔널 처리)
    //            (cookableFilter == nil || favorite.food.attribute.isCookable == cookableFilter!) &&
    //            // 주재료 필터 조건 (배열이 비어있지 않은 경우만 적용)
    //            (mainIngredients.isEmpty || mainIngredients.contains(favorite.food.attribute._mainIngredient))
    //        }
    //        let descriptor = FetchDescriptor<Favorite>(predicate: predicate)
    //        loadFavorites(where: descriptor)
            

    // loadFavorites 함수 수정
     private func loadFavorites(where descriptor: FetchDescriptor<Favorite>) {
         guard let context = modelContext else {
             print("ModelContext가 초기화되지 않았습니다.")
             return // 또는 에러 처리
         }
         do {
             favorites = try context.fetch(descriptor)
         } catch {
             print("오류남 \(error)")
         }
     }
    //    private func loadFavorites(where descriptor: FetchDescriptor<Favorite>) {
    //        do {
    //            favorites = try modelContext.fetch(descriptor)
    //        } catch {
    //            print("오류남 \(error)")
    //        }
    //    }

    enum FavoriteSortType: String, CaseIterable {
        case portable = "휴대성"
        case cookable = "식사 유형"
        case mainIngredient = "주재료"
    }
}

extension FavoriteViewModel.FavoriteSortType: Identifiable {
    var id: Self { self }
}
