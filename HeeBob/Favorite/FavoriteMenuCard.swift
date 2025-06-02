//
//  FavoriteMenuCard.swift
//  HeeBob
//
//  Created by 산들 on 6/1/25.
//

import SwiftUI
import SwiftData

struct FavoriteMenuCard: View {
//    let image: UIImage?
    var food: Food
    var favorite: Favorite
//    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        ZStack {
//            Image(uiImage: <#T##UIImage#>)
//            TODO: BOB이 만든 예제를 보고 이미지 넣기...

            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
                .frame(width: 173, height: 206)
                .shadow(radius: 8)
            
            VStack(spacing: 0) {
                ZStack {
//                    Rectangle() //이미지 넣을 공간
//                        .fill(Color.gray)
//                        .frame(width: 170, height: 150)
//                        .padding(.bottom, 6)
//                        .padding(.top, -20)

                    if let imageData = getDietImageData(for: food),
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
//                            .scaledToFit()
                            .frame(width: 173, height: 130)
                            .padding(.bottom, 6)
                            .padding(.top, -25)
                            .cornerRadius(16)
                    } else {
                        Image(systemName: "questionmark.app.dashed")
                            .resizable()
//                            .scaledToFit()
                            .frame(width: 173, height: 130)
                            .padding(.bottom, 20)
                            .padding(.top, -25)
                    }
                }
                HStack {
                    Text(food.title)
                        .font(.system(size: 24))
                        .bold()
                        .foregroundColor(.primary)
                        .padding(.bottom, 4)
                        .padding(.top, 1)
                }
            }
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

}

//#Preview(traits: .sampleData) {
//    FavoriteMenuCard()
//}
