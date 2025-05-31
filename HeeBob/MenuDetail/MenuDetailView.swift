//
//  MenuDetailView.swift
//  HeeBob
//
//  Created by 산들 on 5/31/25.
//

import SwiftUI

struct MenuDetailView: View {
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
    
    var body: some View {
        VStack {
            Rectangle()
            .foregroundColor(.clear)
            .frame(width: 353, height: 353)
            .background(Color(red: 0.85, green: 0.85, blue: 0.85))
            .cornerRadius(15)
            .overlay(Text("Menu Detail Img"))
            
            VStack {
                Triangle()
                    .fill(Color(red: 1, green: 0.86, blue: 0.8))
                    .frame(width: 15, height: 15)
                    .padding(.bottom, -10)
                    .padding(.trailing, 280)
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.clear)
                    .frame(width: 353, height: 66)
                    .background(Color(red: 1, green: 0.86, blue: 0.8))
                    .padding(.top, 0)
                    .padding(.bottom, 0)
                    .cornerRadius(16)
                    .overlay(
                        Text("여름에는 덥게 겨울에는 춥게")
                            .font(.title)
                            .foregroundColor(.black)
                    )
            }
            
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.gray, lineWidth: 1)
                .foregroundColor(.clear)
                .frame(width: 353, height: 145)
                .padding(.top, 16)
                .overlay(
                    Text("여름에는 먹고 겨울에는 안 먹고 오이는 절대 안먹고")
                        .font(.title)
                        .foregroundColor(.black)
                )
            
            Button(action: { print("찜 삭제, 모달 띄울거임") },
                   label: { Text("찜에서 삭제하기") }
            )
            .padding(.top, 51)
            .font(.title2)
            .foregroundStyle(.gray)
        }
    }
}

#Preview {
    MenuDetailView()
}
