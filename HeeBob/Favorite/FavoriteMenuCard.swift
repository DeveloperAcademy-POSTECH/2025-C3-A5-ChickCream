//
//  FavoriteMenuCard.swift
//  HeeBob
//
//  Created by 산들 on 6/1/25.
//

import SwiftUI
import SwiftData

struct FavoriteMenuCard: View {
    var food: Food
    var favorite: Favorite
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
                .frame(width: 170, height: 209)
            
            VStack(spacing: 0) {
                ZStack {
                    Rectangle() //이미지 넣을 공간
                        .fill(Color.gray)
                        .frame(width: 170, height: 150)
                        .padding(.bottom, 6)
                        .padding(.top, -20)
                }
                HStack {
                Text(food.title)
                    .font(.system(size: 24))
                    .bold()
                    .foregroundColor(.primary)
                    .padding(.bottom, 4)
                    .padding(.top, 1)
                Button {
                    print("찜 삭제임")
                    do {
                        modelContext.delete(favorite)
                           try modelContext.save()
                       } catch {
                           print("삭제 중 오류 발생: \(error.localizedDescription)")
                       }
                } label: {
                    Image(systemName: "x.circle.fill")//x모양임
                        .frame(width: 30)
                }}

            }
        }
    }
}

#Preview {
    FavoriteMenuCard(food: Food(id: UUID(), title: "김치찌개", uniquePoint: "먹고싶은 음식", attribute: FoodAttribute(id: UUID(), isPortable: true, isCookable: true, mainIngredient: .meat)), favorite: Favorite(id: UUID(), food: Food(id: UUID(), title: "김치찌개", uniquePoint: "먹고싶은 음식", attribute: FoodAttribute(id: UUID(), isPortable: true, isCookable: true, mainIngredient: .meat)), createdAt: Date()))
}
