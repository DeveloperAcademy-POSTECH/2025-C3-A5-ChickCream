//
//  AddCard.swift
//  HeeBob
//
//  Created by BoMin Lee on 6/1/25.
//

import SwiftUI

struct AddCard: View {
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 18) {
            Image(.addCircle)
            Text("또 다른 메뉴\n추천받기")
                .multilineTextAlignment(.center)
                .font(.hbTitle)
                .foregroundStyle(Color.hbTextSecondary)
        }
        .padding(.vertical, 57)
        .padding(.horizontal, 98)
        .background(Color.hbBackground)
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .inset(by: 0.5)
                .stroke(Color.hbButtonSecondary, lineWidth: 1)
        )
        .padding()
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    AddCard {
        print("Add")
    }
}
