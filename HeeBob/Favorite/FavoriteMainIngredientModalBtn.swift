//
//  FavoriteMainIngredientModalBtn.swift
//  HeeBob
//
//  Created by 산들 on 6/4/25.
//

import SwiftUI

struct FavoriteMainIngredientModalBtn: View {
    @ObservedObject var favoriteViewModel = FavoriteViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            Button {
                print("초기화")
                // 체크박스 해제 + 주재료 모든 항목 보이게...
            } label: {
                Rectangle()
                    .frame(width: 100, height: 50)
                    .foregroundColor(.blue)
                    .overlay(
                        Text("초기화")
                            .foregroundStyle(.white)
                    )
            }// Hifi에 맞게 디자인해야함.
            Button {
                print("확인")
                dismiss()
                // 왜 호들갑 떨면서 내려가는 지는 모르겠지만 닫히기는 합니다.
            } label: {
                Rectangle()
                    .frame(width: 200, height: 50)
                    .foregroundColor(.blue)
                    .overlay(
                        Text("확인")
                            .foregroundStyle(.white)
                    )
            }
        
        }
    }
}
