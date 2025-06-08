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
    
    @State private var searchText: String = "" // 현재 입력 중인 검색어
    @State private var inputSearchText: String = "" // 사용자가 리턴한 검색어
    
    @State private var recentSearchTextList: [String] = []
    var recentSearchTextListSortedByDesc: [String] {
        recentSearchTextList.reversed()
    }
    
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
                TextField("내가 찜한 메뉴에서 검색하기", text: $inputSearchText)
                    .font(.hbBody2)
                    .foregroundStyle(Color.hbTextPrimary)
                    .padding(.vertical, 9)
                    .padding(.horizontal, 12)
                    .background(Color(red: 0.96, green: 0.96, blue: 0.95))
                    .cornerRadius(12)
                    .onSubmit {
                        searchTextFieldDidEndEditing()
                    }
            }
            
            if favorites.isEmpty {
                if !searchText.isEmpty {
                    Text("검색 결과가 없습니다.")
                        .font(.hbBody2)
                        .foregroundColor(.secondary)
                        .padding(.top, 40)
                } else {
                    HStack {
                        Text("최근 검색")
                            .font(.hbMinimum)
                            .foregroundStyle(Color.hbTextPrimary)
                        
                        Spacer()
                        
                        Button {
                            clearAllButtonDidTap()
                        } label: {
                            Text("전체 삭제")
                                .font(.suite(type: .semibold, size: 16))
                                .foregroundStyle(Color.hbTextSecondary)
                        }
                    }
                    .padding(.top, 24)
                    .padding(.bottom, 16)
                    
                    if recentSearchTextList.isEmpty {
                        Text("최근 검색 기록이 없습니다.")
                            .font(.hbBody2)
                            .foregroundColor(.secondary)
                            .padding(.top, 16)
                    }
                    
                    LazyVStack(spacing: 16) {
                        ForEach(recentSearchTextListSortedByDesc.indices, id: \.self) { searchTextIndex in
                            RecentSearchItemView(index: searchTextIndex, content: recentSearchTextListSortedByDesc[searchTextIndex]) { index in
                                print("did tap \(recentSearchTextListSortedByDesc[index])")
                            } didDeleteButtonTap: { index in
                                print("did delete tap \(recentSearchTextListSortedByDesc[index])")
                            }
                        }
                    }
                }
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
        .onAppear {
            viewDidAppear()
        }
        .onChange(of: searchText, { _, searchText in
            searchTextChanged(for: searchText)
        })
        .onChange(of: inputSearchText, { _, inputSearchText in
            if inputSearchText.isEmpty {
                searchText = ""
            }
        })
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(true)
    }
}

extension SearchView {
    private func viewDidAppear() {
        loadRecentSearchHistory()
    }
    
    private func loadRecentSearchHistory() {
        if let anyArray = UserDefaults.standard.array(forKey: UserDefaultsKey.recentSearchHistory.rawValue) {
            recentSearchTextList = anyArray.compactMap { $0 as? String }
        }
    }
    
    private func searchTextFieldDidEndEditing() {
        searchText = inputSearchText
        
        // 최근 검색 기록에 저장
        recentSearchTextList.append(searchText)
        saveRecentSearchHistory()
    }
    
    private func saveRecentSearchHistory() {
        UserDefaults.standard.set(recentSearchTextList, forKey: UserDefaultsKey.recentSearchHistory.rawValue)
    }
    
    private func searchTextChanged(for searchText: String) {
        fetchSearchResults(containing: searchText)
    }
    
    private func clearAllButtonDidTap() {
        clearRecentSearchHistory()
    }
    
    private func clearRecentSearchHistory() {
        recentSearchTextList.removeAll()
        saveRecentSearchHistory()
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

struct RecentSearchItemView: View {
    let index: Int
    let content: String
    let didContentTap: (_ index: Int) -> Void
    let didDeleteButtonTap: (_ index: Int) -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "clock")
                .renderingMode(.template)
                .foregroundStyle(Color.hbTextSecondary)
            
            Spacer()
                .frame(width: 16)
            
            Button {
                didContentTap(index)
            } label: {
                Text(content)
                    .font(.hbBody2)
                    .foregroundStyle(Color.hbTextPrimary)
            }

            Spacer()
            
            Button {
                didDeleteButtonTap(index)
            } label: {
                Image(systemName: "xmark")
                    .renderingMode(.template)
                    .foregroundStyle(Color.hbTextSecondary)
            }
        }
    }
}

#Preview {
    SearchView()
}
