//
//  ResultCard.swift
//  HeeBob
//
//  Created by BoMin Lee on 5/31/25.
//

import SwiftUI

struct ResultCard: View {
    let image: Image
    let title: String
    let description: String

    var body: some View {
        // FIXME: 레이아웃 확정되면 수정해야 함.
        VStack(alignment: .leading, spacing: 0) {
            image
                .resizable()
                .scaledToFill()
                .frame(height: 180)
                .clipped()
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .frame(alignment: .leading)
                    .font(.headline)
                    .foregroundColor(.black)
                    .lineLimit(1)

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
        }
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 4)
        .padding(.horizontal)
    }
}

#Preview {
    ResultCard(image: Image("Sample 1"), title: "닭갈비", description: "부드럽고 살짝 매콤해요")
}
