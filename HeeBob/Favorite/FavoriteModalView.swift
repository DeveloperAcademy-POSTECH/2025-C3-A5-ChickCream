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
            VStack(alignment: .leading) {
                Text("휴대성")
                    .padding()
                Divider()
                //TODO: foreach써서 버튼 반복 돌리기... favorite받아온거 이용해서
                Button {
                    print("모두 보기")
                } label: {
                    Text("모두 보기")
                        .padding()
                }
                Button {
                    favoriteViewModel.portableSortTypeSelected(for: true)
                } label: {
                    Text("챙겨 나가기 좋아요")
                }
                Button {
                    favoriteViewModel.portableSortTypeSelected(for: false)
                } label: {
                    Text("자리에서 먹기 좋아요")
                }
            }
                .presentationDetents([.fraction(0.5)])
        } else if favoriteViewModel.showingfavoriteSortType == .cookable {
            Text("식사 준비")
            Divider()
                .presentationDetents([.fraction(0.5)])
        } else if favoriteViewModel.showingfavoriteSortType == .mainIngredient {
            Text("주재료")
            Divider()
                .presentationDetents([.fraction(0.5)])
        }
    }
}

//#Preview {
//    FavoriteModalView()
//}
