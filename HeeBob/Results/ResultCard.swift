//
//  ResultCard.swift
//  HeeBob
//
//  Created by BoMin Lee on 5/31/25.
//

import SwiftUI

struct ResultCard: View {
    let food: Food
    let action: () -> Void
    
    init(food: Food, action: @escaping () -> Void) {
        self.food = food
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // FIXME: 이미지 저장 형식 및 uuid 확인 후 수정 예정
            Image("Sample 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
            
            HStack {
                VStack(alignment: .leading, spacing: 0){
                    Text(food.title)
                        .font(.hbTitle)
                        .foregroundStyle(Color.hbTextPrimary)
                        .lineLimit(1)
                    // TODO: 전체 회의 내용 토대로 넣을지 말지 결정
//                    Text(food.uniquePoint)
//                        .font(.hbSubtitle)
//                        .foregroundColor(Color.hbTextSecondary)
//                        .lineLimit(2)
//                        .multilineTextAlignment(.leading)
                }
                Spacer()
                Image(.heart)
                    .frame(width: 40, height: 40)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
        }
        .background(Color.hbBackground)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .inset(by: 0.5)
                .stroke(Color.hbButtonSecondary, lineWidth: 1)
        )
        .onTapGesture {
            action()
        }
    }
}
