//
//  FavoriteModalView.swift
//  HeeBob
//
//  Created by 산들 on 6/3/25.
//

import SwiftUI

struct FavoriteModalView: View {
    @ObservedObject var favoriteViewModel = FavoriteViewModel()
    var body: some View {
        if favoriteViewModel.showingfavoriteSortType == .portable {
            Text("Hello, portable!")
                .presentationDetents([.fraction(0.5)])
        } else if favoriteViewModel.showingfavoriteSortType == .cookable {
            Text("Hello, cookable!")
                .presentationDetents([.fraction(0.5)])
        } else if favoriteViewModel.showingfavoriteSortType == .mainIngredient {
            Text("Hello, mainingredient!")
                .presentationDetents([.fraction(0.5)])
        }
        
    }
}

#Preview {
    FavoriteModalView()
}
