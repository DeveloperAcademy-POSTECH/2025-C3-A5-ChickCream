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
            ZStack {
                RoundedRectangle(cornerRadius: 99)
                    .stroke(filterButtonColors.button, lineWidth: 0.5)
                    .frame(width: 104, height: 50)
                RoundedRectangle(cornerRadius: 99)
                    .fill(Color.clear)
                    .frame(width: 104, height: 50)
                    .overlay(
                        HStack{
                            Text(title)
                                .foregroundStyle(filterButtonColors.text)
                                .font(.hbMinimum)
                            Image(systemName: "chevron.down")
                                .foregroundStyle(filterButtonColors.text)
                        }
                    )
            }
            .padding(.top, 16)
            .padding(.bottom, 8)
        }
    }
}
