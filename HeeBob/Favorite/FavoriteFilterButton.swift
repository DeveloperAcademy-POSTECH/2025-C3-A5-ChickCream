//
//  FavoriteFilterButton.swift
//  HeeBob
//
//  Created by 산들 on 6/3/25.
//

import Foundation
import SwiftUI
// TODO: 모두 보기 상태 = 회색. 하나라도 필터 선택되어 있으면 주황색. 모달뷰를 내려도 유지되어야함. 따라서 뷰모델의 상태에 따라서 버튼 색 지정... 기존의 있는거 가져다 쓰면 될 듯?
struct FavoriteFilterButton: View {
    @ObservedObject var favoriteViewModel: FavoriteViewModel
    
    let title: String
    let filterType: FavoriteViewModel.FavoriteSortType
    let action: () -> Void

//    var buttonColorChange: Color {
//        if isSelected {
//          return Color.hbPrimary
//        } else {
//        return Color.hbButtonSecondary
//    }}
//
//    var textColorChange: Color {
//        if isSelected {
//          return Color.hbPrimary
//        } else {
//        return Color.hbTextSecondary
//    }}
//    
    // 뷰모델에 필터 타입을 넘겨주고 색상 값을 한번에 받아옵니다.
    private var colors: (button: Color, text: Color) {
        return favoriteViewModel.getFilterButtonColors(for: filterType)
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 99)
                    .stroke(colors.button, lineWidth: 0.5)
                    .frame(width: 104, height: 50)
                RoundedRectangle(cornerRadius: 99)
                    .fill(Color.clear)
                    .frame(width: 104, height: 50)
                    .overlay(
                        HStack{
                            Text(title)
                                .foregroundStyle(colors.text)
                                .font(.hbMinimum)
                            Image(systemName: "chevron.down")
                                .foregroundStyle(colors.text)
                        }
                    )
            }
        }
    }
}
