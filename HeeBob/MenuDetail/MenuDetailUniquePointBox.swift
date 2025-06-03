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
        VStack {
            Triangle()
                .fill(Color(red: 1, green: 0.86, blue: 0.8))
                .frame(width: 20, height: 15)
                .padding(.bottom, -10)
                .padding(.top, 0)
                .padding(.trailing, 300)
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxHeight: 66, alignment: .topLeading)
                .background(Color.hbPrimaryLighten)
                .cornerRadius(16)
                .padding(.top, 0)
                .padding(.bottom, 0)
                .padding(.horizontal, 16)
                .overlay(alignment: .leading) {
                    Text(food.uniquePoint)
                        .font(.hbBody1)
                        .foregroundColor(.black)
                        .padding(16)
                        .padding(.leading, 14)
                        .fixedSize(horizontal: false, vertical: true) //2줄 이상 가능하게
                        .frame(alignment: .leading)
                }
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
