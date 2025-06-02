//
//  FavoriteFilterButton.swift
//  HeeBob
//
//  Created by 산들 on 6/3/25.
//

import SwiftUI

struct FavoriteFilterButton: View {
    @StateObject var favoriteViewModel = FavoriteViewModel()
    @State var btnColorChange : Bool = false
    
    var body: some View {
        HStack {
            Button {
                favoriteViewModel.favoriteSortType = .portable
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 99)
                        .stroke(Color.red, lineWidth: 2)
                        .frame(width: 104, height: 50)
                    RoundedRectangle(cornerRadius: 99)
                        .fill(Color.clear)
                        .frame(width: 104, height: 50)
                        .overlay(
                            HStack{
                                Text("휴대성")
                                    .foregroundStyle(Color.hbPrimary)
                                Image(systemName: "chevron.down")
                                    .foregroundStyle(Color.hbPrimary)
                            }
                        )
                }
            }
            Button {
                favoriteViewModel.favoriteSortType = .cookable
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 99)
                        .stroke(Color.red, lineWidth: 2)
                        .frame(width: 104, height: 50)
                    RoundedRectangle(cornerRadius: 99)
                        .fill(Color.clear)
                        .frame(width: 104, height: 50)
                        .overlay(
                            HStack {
                                Text("식사 유형")
                                    .foregroundStyle(Color.hbPrimary)
                                Image(systemName: "chevron.down")
                                    .foregroundStyle(Color.hbPrimary)
                            }
                        )
                }
                Button {
                    favoriteViewModel.favoriteSortType = .mainIngredient
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 99)
                            .stroke(Color.red, lineWidth: 2)
                            .frame(width: 104, height: 50)
                        RoundedRectangle(cornerRadius: 99)
                            .fill(Color.clear)
                            .frame(width: 104, height: 50)
                            .overlay(
                                HStack {
                                    Text("주재료")
                                        .foregroundStyle(Color.hbPrimary)
                                    Image(systemName: "chevron.down")
                                        .foregroundStyle(Color.hbPrimary)
                                }
                            )
                    }
                }
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
