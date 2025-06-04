//
//  SearchView.swift
//  HeeBob
//
//  Created by BoMin Lee on 6/5/25.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @EnvironmentObject var router: NavigationRouter
    
    @Query private var allFavorites: [Favorite]
    
    @State private var searchText: String = ""
    
    var filteredFavorites: [Favorite] {
        guard !searchText.isEmpty else { return [] }
        return allFavorites.filter {
            $0.food.title.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.hbTextPrimary)
                        .frame(width: 13)
                }
                TextField("음식 이름 검색", text: $searchText)
                    .font(.hbBody2)
                    .foregroundStyle(Color.hbDisabled)
                    .padding(.vertical, 9)
                    .padding(.horizontal, 12)
                    .background(Color(red: 0.96, green: 0.96, blue: 0.95))
                    .cornerRadius(12)
                
            }
            if filteredFavorites.isEmpty {
                Text("검색 결과가 없습니다.")
                    .foregroundColor(.secondary)
                    .padding(.top, 40)
            } else {
                ScrollView {
                    Spacer()
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(filteredFavorites) { favorite in
                            Button {
                                router.push(.detail(food: favorite.food))
                            } label: {
                                // FIXME: 통합 후 주석 해제 예정
                                // FavoriteMenuCard(food: favorite.food, favorite: favorite)
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SearchView()
}
