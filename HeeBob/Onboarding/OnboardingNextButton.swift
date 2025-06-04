//
//  OnboardingNextButton.swift
//  HeeBob
//
//  Created by 임영택 on 5/31/25.
//

import SwiftUI

struct OnboardingNextButton: View {
    let title: String
    let didButtonTap: () -> Void
    
    var body: some View {
        Button {
            didButtonTap()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color.hbPrimary)
                
                Text(title)
                    .font(.hbSubtitle)
                    .foregroundColor(.white)
            }
        }
        .frame(height: 72)
    }
}

#Preview {
    OnboardingNextButton(title: "다음") {
        print("button tapped")
    }
}
