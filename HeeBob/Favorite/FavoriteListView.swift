//
//  FavoriteListView.swift
//  HeeBob
//
//  Created by 산들 on 6/1/25.
//

import SwiftUI
import SwiftData

struct FavoriteListView: View {
    @StateObject var favoriteViewModel = FavoriteViewModel()
    //    var food: [Food]
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack(spacing: 0) {
            FavoriteFilterControl(favoriteViewModel: favoriteViewModel)
            CardGrid(favorites: favoriteViewModel.favorites)
        }
        .onAppear {
            favoriteViewModel.listViewDidAppear(modelContext: modelContext)
        }
    }
}

struct CardGrid: View {
    var favorites: [Favorite]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ] // 열 혹은 행의 레이아웃 정의. flexible은 해당 열이나 행의 너비,높이가 유동적이게 지정.
    var body: some View {
        ScrollView {
            Spacer()
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(favorites) { favorite in
                    NavigationLink {
                        // FoodDetailView(food: favorite.food)
                        //  .toolbarRole(.editor)
                    } label: {
                        FavoriteMenuCard(food: favorite.food, favorite: favorite)
                    }
                }
            }
        }
    }
}

#Preview(traits: .sampleData) {
    FavoriteListView()
}
