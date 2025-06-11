//
//  FavoriteFilterButton.swift
//  HeeBob
//
//  Created by 산들 on 6/3/25.
//

import Foundation
import SwiftUI

struct FavoriteFilterButton: View {
    @ObservedObject var favoriteViewModel: FavoriteViewModel
    
    let title: String
    let filterType: FavoriteViewModel.FavoriteSortType
    let action: () -> Void
    
    
    /// 뷰모델에 필터 타입을 넘겨주고 색상 값을 한번에 받아옵니다.
    private var filterButtonColors: (button: Color, text: Color) {
        return favoriteViewModel.getFilterButtonColors(for: filterType)
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 4) {
                Text(title)
                    .foregroundStyle(filterButtonColors.text)
                    .font(.hbBody2)
                Image(systemName: "chevron.down")
                    .foregroundStyle(filterButtonColors.text)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(
                Capsule()
                    .stroke(filterButtonColors.button, lineWidth: 1)
            )
            .padding(.top, 16)
            .padding(.bottom, 8)
        }
    }
}
