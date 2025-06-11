//
//  TestView.swift
//  HeeBob
//
//  Created by 임영택 on 5/31/25.
//

import SwiftUI
import SwiftData

/// 모든 Food 엔티티를 조회하는 임시 뷰
/// 홈 뷰 구현 후에 제거한다
struct TestView: View {
    @Query(sort: \Food.title, order: .forward) var foods: [Food]
    
    var body: some View {
        VStack {
            List {
                ForEach(foods) { food in
                    VStack(alignment: .leading) {
                        Text(food.title)
                        
                        Text("isCookable: \(food.attribute.isCookable)")
                        Text("isPortable: \(food.attribute.isPortable)")
                        Text("mainIngredient: \(food.attribute.mainIngredient)")
                        
                        if let imageData = getDietImageData(for: food),
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        } else {
                            Image(systemName: "questionmark.app.dashed")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        }
                    }
                }
            }
        }
    }
}

extension TestView {
    private func getDietImageData(for food: Food) -> Data? {
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

#if DEBUG
#Preview(traits: .sampleData) {
    TestView()
}
#endif
