//
//  MenuDetailImage.swift
//  HeeBob
//
//  Created by 산들 on 6/4/25.
//

import SwiftUI

struct MenuDetailImageBox: View {
    var food: Food
    
    var body: some View {
        if let imageData = getFoodImageData(for: food),
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .frame(maxHeight: 361, alignment: .topLeading)
                .cornerRadius(16)
                .padding(.vertical, 0)
                .padding(.horizontal, 16)
        } else {
            Image(systemName: "questionmark.app.dashed")
                .resizable()
                .frame(maxHeight: 361, alignment: .topLeading)
                .cornerRadius(16)
                .padding(.vertical, 0)
                .padding(.horizontal, 16)
        }
    }
}

extension MenuDetailImageBox {
    private func getFoodImageData(for food: Food) -> Data? {
        guard let url = Bundle.main.url(forResource: food.id.uuidString.lowercased(), withExtension: "jpg") else {
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

