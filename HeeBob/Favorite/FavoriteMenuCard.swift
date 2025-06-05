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
    
    var body: some View {
        VStack(spacing: 0) {
            if let imageData = getDietImageData(for: food),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                 .resizable()
                 .frame(width: 173, height: 130)
                 .cornerRadius(16)
         }  else {
                Image(systemName: "questionmark.app.dashed")
                    .resizable()
                    .frame(width: 173, height: 130)
                    .cornerRadius(16)
            }
            
            Text(food.title)
                .font(.hbBody2)
                .frame(height: 66, alignment: .top)
                .bold()
                .foregroundColor(.hbTextPrimary)
                .lineLimit(2)
                .padding(.top, 10)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 4)
        )
        .frame(width: 173)
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



//#Preview(traits: .sampleData) {
//    FavoriteMenuCard()
//}
