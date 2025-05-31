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
    
    
    func makeHighlightedComment(fullText: String, highlightText: String) -> AttributedString {
        var string = AttributedString(fullText)
        if let range = string.range(of: highlightText) {
            string[range].font = .title3.weight(.bold)
            string[range].backgroundColor = .red
        }
        return string
    }

    
    var body: some View {
        VStack {
            Rectangle()
            .foregroundColor(.clear)
            .frame(maxWidth: .infinity, maxHeight: .infinity , alignment: .topLeading)
            .background(Color(red: 0.85, green: 0.85, blue: 0.85))
            .cornerRadius(16)
            .padding(.horizontal, 20)
            .overlay(Text("Menu Detail Img"))
            
            VStack {
                Triangle()
                    .fill(Color(red: 1, green: 0.86, blue: 0.8))
                    .frame(width: 20, height: 15)
                    .padding(.bottom, -10)
                    .padding(.trailing, 280)
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .topLeading)
                    .background(Color(red: 1, green: 0.86, blue: 0.8))
                    .cornerRadius(16)
                    .padding(.top, 0)
                    .padding(.bottom, 0)
                    .padding(.horizontal, 20)
                    .overlay(
                        Text("여름에는 덥게 겨울에는 춥게")
                            .font(.title)
                            .foregroundColor(.black)
                    )
            }
            
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.gray, lineWidth: 1)
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity,maxHeight: 200, alignment: .topLeading)
                .padding(.top, 16)
                .padding(.horizontal, 20)
                .overlay(
                    VStack {
                        HStack {
                            Image(systemName: "checkmark")
                            Text("대충 휴대성 설명")}
                        .padding(.bottom, 4)
                        .padding(.top, 21)
                        HStack {
                            Image(systemName: "checkmark")
                            Text("대충 요리유무 설명")}
                        .padding(.bottom, 4)
                        .padding(.top, 4)
                        HStack {
                            Image(systemName: "checkmark")
                            Text("대충 주재료 설명")}
                        .padding(.top, 4)
                    }
                )
                    
            Button(action: { print("찜 삭제, 모달 띄울거임") },
                   label: { Text("찜에서 삭제하기") }
            )
            .padding()
            .font(.title2)
            .foregroundStyle(.gray)
        }
    }
}

#Preview {
    MenuDetailView()
}
