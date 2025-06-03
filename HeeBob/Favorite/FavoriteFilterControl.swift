//
//  FavoriteFilterButton.swift
//  HeeBob
//
//  Created by 산들 on 6/3/25.
//

import SwiftUI

struct FavoriteFilterControl: View {
    @StateObject var favoriteViewModel = FavoriteViewModel()
    @State var btnColorChange : Bool = false
    var favorite: Favorite
//    let filterType: FavoriteViewModel.FavoriteSortType
    
    var body: some View {
        HStack {
            ForEach(FavoriteViewModel.FavoriteSortType.allCases, id: \.self) { sortType in
                FavoriteFilterButton(title: sortType.rawValue, isSelected: sortType == favoriteViewModel.showingfavoriteSortType) {
                    favoriteViewModel.filterSelectButtonTapped(for: sortType)
                }
            }
        }
        .sheet(item: $favoriteViewModel.showingfavoriteSortType) { modalType in
            switch modalType {
            case .portable:
                FavoriteModalView(favoriteViewModel: favoriteViewModel, favorite: favorite)
            case .cookable:
                FavoriteModalView(favoriteViewModel: favoriteViewModel, favorite: favorite)
            case .mainIngredient:
                FavoriteModalView(favoriteViewModel: favoriteViewModel, favorite: favorite)
            }
        }
    }
    
    @ViewBuilder
    func HellowWorldView() -> some View {
        Text("Hello World")
    }
}

//#Preview {
//    FavoriteFilterControl()
//}
