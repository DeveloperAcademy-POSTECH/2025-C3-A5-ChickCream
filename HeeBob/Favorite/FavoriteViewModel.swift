//
//  FavoriteViewModel.swift
//  HeeBob
//
//  Created by 산들 on 6/3/25.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    enum FavoriteSortType: String, CaseIterable {
        case portable = "휴대성"
        case cookable = "식사 유형"
        case mainIngredient = "주재료"
    }
    
    @Published var showingfavoriteSortType: FavoriteSortType? = nil
    
    func filterSelectButtonTapped(for sortType: FavoriteSortType) {
        showingfavoriteSortType = sortType
    }
}

extension FavoriteViewModel.FavoriteSortType: Identifiable {
    var id: Self { self }
}
