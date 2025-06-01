//
//  MenuDetailView.swift
//  HeeBob
//
//  Created by 산들 on 5/31/25.
//
//TODO: Food 엔티티 주입 후 완전 완성할 것!
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
            .frame(maxHeight: 361 , alignment: .topLeading)
            .background(Color.gray)
            .cornerRadius(16)
            .padding(.top, 0)
            .padding(.horizontal, 16)
            .padding(.bottom, 0)
            .overlay(Text("Menu Detail Img"))
            
            VStack {
                Triangle()
                    .fill(Color(red: 1, green: 0.86, blue: 0.8))
                    .frame(width: 20, height: 15)
                    .padding(.bottom, -10)
                    .padding(.top, 0)
                    .padding(.trailing, 300)
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, maxHeight: 66, alignment: .topLeading)
                    .background(Color.hbPrimaryLighten)
                    .cornerRadius(16)
                    .padding(.top, 0)
                    .padding(.bottom, 0)
                    .padding(.horizontal, 16)
                    .overlay(
                        Text("여름에는 덥게 겨울에는 춥게")
                            .font(.hbBody1)
                            .foregroundColor(.black)
                            .padding(.trailing, 110)
                    )
            }
            
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.gray, lineWidth: 1)
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity,maxHeight: 148, alignment: .topLeading)
                .padding(.top, 16)
                .padding(.horizontal, 16)
                .overlay(
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "checkmark")
                            Text(" 대충 휴대성 설명")}
                        .padding(.bottom, 4)
                        .padding(.top, 21)
                        HStack {
                            Image(systemName: "checkmark")
                            Text(" 대충 요리해먹기 설명")}
                        .padding(.bottom, 4)
                        .padding(.top, 4)
                        HStack {
                            Image(systemName: "checkmark")
                            Text(" 대충 주재료 설명")}
                        .padding(.top, 4)
                    }
                        .padding(.trailing, 150)
                )
                    
            Button(action: { print("찜 삭제, 모달 띄울거임") },
                   label: { Text("찜에서 삭제하기") }
            )
            .padding(.top, 40)
            .font(.hbSubtitle)
            .foregroundStyle(Color.hbDisabled)
        }
    }
}

#Preview {
    MenuDetailView()
}
