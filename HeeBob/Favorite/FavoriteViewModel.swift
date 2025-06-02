//
//  FavoriteViewModel.swift
//  HeeBob
//
//  Created by 산들 on 6/3/25.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    enum FavoriteSortType {
        case portable, cookable, mainIngredient
    }
    
    @Published var favoriteSortType: FavoriteSortType? = nil
}

extension FavoriteViewModel.FavoriteSortType: Identifiable {
    var id: Self { self }
}
