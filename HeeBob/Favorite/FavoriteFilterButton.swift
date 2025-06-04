//
//  FavoriteFilterButton.swift
//  HeeBob
//
//  Created by 산들 on 6/3/25.
//

import Foundation
import SwiftUI

struct FavoriteFilterButton: View {
    @ObservedObject var favoriteViewModel = FavoriteViewModel()
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var buttonColorChange: Color {
        if isSelected {
          return Color.hbPrimary
        } else {
        return Color.hbButtonSecondary
    }}

    var textColorChange: Color {
        if isSelected {
          return Color.hbPrimary
        } else {
        return Color.hbTextSecondary
    }}
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 99)
                    .stroke(buttonColorChange, lineWidth: 0.5)
                    .frame(width: 104, height: 50)
                RoundedRectangle(cornerRadius: 99)
                    .fill(Color.clear)
                    .frame(width: 104, height: 50)
                    .overlay(
                        HStack{
                            Text(title)
                                .foregroundStyle(textColorChange)
                                .font(.hbMinimum)
                            Image(systemName: "chevron.down")
                                .foregroundStyle(textColorChange)
                        }
                    )
            }
        }
    }
}
