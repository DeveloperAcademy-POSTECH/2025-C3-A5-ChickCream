//
//  FavoriteFilterButton.swift
//  HeeBob
//
//  Created by 산들 on 6/3/25.
//

import SwiftUI

struct FavoriteFilterButton: View {
    @StateObject var favoriteViewModel = FavoriteViewModel()
    
    var body: some View {
        HStack {
            Button {
                favoriteViewModel.favoriteSortType = .portable
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 99)
                        .fill(Color.clear)
                        .frame(width: 104, height: 50)
                }
            }
            Button {
                favoriteViewModel.favoriteSortType = .cookable
            } label: {
                RoundedRectangle(cornerRadius: 99)
                    .frame(width: 104, height: 50)
            }
            Button {
                favoriteViewModel.favoriteSortType = .mainIngredient
            } label: {
                RoundedRectangle(cornerRadius: 99)
                    .frame(width: 104, height: 50)
            }
        }
        .sheet(item: $favoriteViewModel.favoriteSortType) { modalType in
            switch modalType {
            case .portable:
                FavoriteModalView(favoriteViewModel: favoriteViewModel)
            case .cookable:
                FavoriteModalView(favoriteViewModel: favoriteViewModel)
            case .mainIngredient:
                FavoriteModalView(favoriteViewModel: favoriteViewModel)
            }
        }
    }
}

#Preview {
    FavoriteFilterButton()
}
