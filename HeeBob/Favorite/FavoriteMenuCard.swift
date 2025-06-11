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
    var geometry: GeometryProxy
    
    var body: some View {
        VStack(spacing: 0) {
            if let imageData = getDietImageData(for: food),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width * 0.44, height: geometry.size.height * 0.172)
                    .clipShape(RoundedTopCorners(radius: 16))
            }  else {
                Image(systemName: "questionmark.app.dashed")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width * 0.44, height: geometry.size.height * 0.172)
                    .clipShape(RoundedTopCorners(radius: 16))
            }
            Text(food.title)
                .font(.hbBody2)
                .frame(maxWidth: .infinity, minHeight: 66, alignment: .topLeading)
                .bold()
                .foregroundColor(.hbTextPrimary)
                .lineLimit(2)
                .padding(.top, 12)
                .padding(.leading, 16)
                .multilineTextAlignment(.leading)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.hbButtonSecondary, lineWidth: 1)
                .fill(Color.hbBackground)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}
private func getDietImageData(for food: Food) -> Data? {
    guard let url = Bundle.main.url(forResource: (food.id.uuidString.lowercased()), withExtension: "jpg") else {
        print("cannot find image file \(food.id.uuidString.lowercased()).jpg")
        return nil
    }
    
    do {
        let data = try Data(contentsOf: url)
        print(data)
        return data
    } catch {
        print("error: \(error)")
        return nil
    }
}

struct RoundedTopCorners: Shape {
    var radius: CGFloat = 16
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // 상단 좌/우 모서리만 둥글게
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY)) // bottom left
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        path.addQuadCurve(
            to: CGPoint(x: rect.minX + radius, y: rect.minY),
            control: CGPoint(x: rect.minX, y: rect.minY)
        )
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.minY + radius),
            control: CGPoint(x: rect.maxX, y: rect.minY)
        )
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        path.closeSubpath()
        return path
    }
}
