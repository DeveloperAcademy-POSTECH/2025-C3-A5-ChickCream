//
//  FavoriteMainIngredientModalBtn.swift
//  HeeBob
//
//  Created by 산들 on 6/4/25.
//

import SwiftUI

struct FavoriteMainIngredientModalBtn: View {
    @ObservedObject var favoriteViewModel: FavoriteViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            Button {
                print("초기화")
                favoriteViewModel.isForkBeefToggle = false
                favoriteViewModel.isChickenDuckMeatToggle = false
                favoriteViewModel.isFishToggle = false
                favoriteViewModel.isTofuEggToggle = false
            } label: {
                Rectangle()
                    .frame(width: 116, height: 72)
                    .foregroundColor(.hbPrimaryLighten)
                    .cornerRadius(16)
                    .overlay(
                        Text("초기화")
                            .font(.hbSubtitle)
                            .foregroundStyle(Color.hbPrimary)
                    )
            }// TODO: Hifi에 맞게 디자인해야함.
            Button {
                print("확인")
                dismiss()
                // FIXME: 왜 호들갑 떨면서 내려가는 지는 모르겠지만 닫히기는 합니다.
            } label: {
                Rectangle()
                    .frame(width: 235, height: 72)
                    .foregroundColor(.hbPrimary)
                    .cornerRadius(16)
                    .overlay(
                        Text("확인")
                            .font(.hbSubtitle)
                            .foregroundStyle(.white)
                    )
            }
        
        }
    }
}
