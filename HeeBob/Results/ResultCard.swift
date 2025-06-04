//
//  ResultCard.swift
//  HeeBob
//
//  Created by BoMin Lee on 5/31/25.
//

import SwiftUI
import SwiftData

struct ResultCard: View {
    let food: Food
    let action: () -> Void
    
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [Favorite]
    
    var isFavorite: Bool {
        favorites.contains(where: { $0.food.id == food.id })
    }
    
    init(food: Food, action: @escaping () -> Void) {
        self.food = food
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if let imageData = getFoodImageData(for: food),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            } else {
                Image(systemName: "questionmark.app.dashed")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 0){
                    Text(food.title)
                        .font(.hbTitle)
                        .foregroundStyle(Color.hbTextPrimary)
                        .lineLimit(1)
                }
                Spacer()
                Button(action: toggleFavorite) {
                    Image(isFavorite ? .heartFill : .heart)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .buttonStyle(.plain)
                .contentShape(Rectangle())
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
        }
        .background(Color.hbBackground)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .inset(by: 0.5)
                .stroke(Color.hbButtonSecondary, lineWidth: 1)
        )
        .onTapGesture {
            action()
        }
    }
}

extension ResultCard {
    private func toggleFavorite() {
        if let existing = favorites.first(where: { $0.food.id == food.id }) {
            modelContext.delete(existing)
            try! modelContext.save()
        } else {
            let newFavorite = Favorite(id: UUID(), food: food, createdAt: Date())
            modelContext.insert(newFavorite)
            try! modelContext.save()
        }
    }
    
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
