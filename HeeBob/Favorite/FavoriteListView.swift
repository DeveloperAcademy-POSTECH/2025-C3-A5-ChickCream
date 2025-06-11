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
    
    @Environment(\.modelContext) var modelContext
    
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        VStack(spacing: 0) {
            FavoriteFilterControl(favoriteViewModel: favoriteViewModel)
            CardGrid(favorites: favoriteViewModel.favorites) { favorite in
                router.push(.detail(food: favorite.food))
            }
        }
        .onAppear {
            favoriteViewModel.listViewDidAppear(modelContext: modelContext)
        }
        .HBNavigationBar(
            leftView: {
                EmptyView()
            },
            centerView: {
                Text("찜한 메뉴")
                    .font(.hbSubtitle)
                    .foregroundStyle(Color.hbTextPrimary)
            },
            rightView: {
                Button {
                    router.push(.search)
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color.hbTextPrimary)
                        .frame(width: 24, height: 24)
                }
            }
        )
        .ignoresSafeArea(edges: .bottom)
        .HBNavigationBarBackButtonHidden(false)
    }
}

struct CardGrid: View {
    var favorites: [Favorite]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible(), spacing: 6)
    ] // 열 혹은 행의 레이아웃 정의. flexible은 해당 열이나 행의 너비,높이가 유동적이게 지정.
    
    let didItemTap: (_ favorite: Favorite) -> Void
    
    init(favorites: [Favorite], didItemTap: @escaping (_ favorite: Favorite) -> Void) {
        self.favorites = favorites
        self.didItemTap = didItemTap
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Spacer()
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(favorites) { favorite in
                        Button {
                            didItemTap(favorite)
                        } label: {
                            FavoriteMenuCard(food: favorite.food, favorite: favorite, geometry: geometry)
                                .padding(.horizontal, 8)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

#if DEBUG
#Preview(traits: .sampleData) {
    FavoriteListView()
}
#endif
