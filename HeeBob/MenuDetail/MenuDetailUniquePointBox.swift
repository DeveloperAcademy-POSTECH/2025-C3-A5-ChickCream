//
//  MenuDetailUniquePointBox.swift
//  HeeBob
//
//  Created by 산들 on 6/4/25.
//

import SwiftUI

struct MenuDetailUniquePointBox: View {
    var food: Food
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
            Triangle()
                .fill(Color(red: 1, green: 0.86, blue: 0.8))
                .frame(width: 20, height: 15)
            Spacer()
        }
        .padding(.leading, 32)
            
            Text(food.uniquePoint)
                .font(.hbBody1)
                .foregroundColor(.black)
                .padding(16)
                .padding(.leading, 14)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(4)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.hbPrimaryLighten)
                        .frame(minHeight: 66, maxHeight: 120)
                        .padding(.horizontal, 16)
                )
        }
    }
    
    struct Triangle: Shape {
        func path(in rect: CGRect) -> Path {
            Path { path in
                path.move(to: CGPoint(x: rect.midX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            }
        }
    }
}

#Preview {
    MenuDetailUniquePointBox(
        food: Food(
            id: UUID(),
            title: "대표 메뉴",
            uniquePoint: "가나다라마바사가가나다가나가나다라마바사가가나다가나다라마바사가가나다라마바사가사바사가다라마바사가가나", attribute: FoodAttribute(id: UUID(), isPortable: true, isCookable: true, mainIngredient: .beanTofuEgg)
        )
    )
}

