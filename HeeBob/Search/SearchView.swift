//
//  SearchView.swift
//  HeeBob
//
//  Created by BoMin Lee on 6/5/25.
//

import SwiftUI
import SwiftData
import OSLog

struct SearchView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @EnvironmentObject var router: NavigationRouter
    
    @State private var favorites: [Favorite] = []
    
    @State private var searchText: String = ""
    
    private let logger = Logger.category("SearchView")
    
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
                    .foregroundStyle(Color.hbTextPrimary)
                    .padding(.vertical, 9)
                    .padding(.horizontal, 12)
                    .background(Color(red: 0.96, green: 0.96, blue: 0.95))
                    .cornerRadius(12)
                
            }
            if favorites.isEmpty {
                Text("검색 결과가 없습니다.")
                    .font(.hbBody2)
                    .foregroundColor(.secondary)
                    .padding(.top, 40)
            } else {
                ScrollView {
                    Spacer()
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(favorites) { favorite in
                            Button {
                                router.push(.detail(food: favorite.food))
                            } label: {
                                FavoriteMenuCard(food: favorite.food, favorite: favorite)
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .onChange(of: searchText, { _, searchText in
            searchTextChanged(for: searchText)
        })
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(true)
    }
}

extension SearchView {
    private func searchTextChanged(for searchText: String) {
        fetchSearchResults(containing: searchText)
    }
    
    private func fetchSearchResults(containing searchText: String) {
        let descriptor = FetchDescriptor<Favorite>(predicate: #Predicate { favorite in
            favorite.food.title.localizedStandardContains(searchText)
        })
        
        do {
            favorites = try modelContext.fetch(descriptor)
        } catch {
            logger.error("❌ 찜 검색 중 문제가 발생했습니다. \(error)")
        }
    }
}

#Preview {
    SearchView()
}
