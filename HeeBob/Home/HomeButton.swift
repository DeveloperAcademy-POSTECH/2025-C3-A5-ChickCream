//
//  HomeButton.swift
//  HeeBob
//
//  Created by 임영택 on 6/4/25.
//

import SwiftUI

struct HomeButton: View {
    let title: String
    let didTap: () -> Void
    
    var body: some View {
        Button {
            didTap()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.hbPrimaryLighten)
                    .stroke(LinearGradient(
                        stops: [
                            .init(color: .white, location: 0.0),
                            .init(color: .clear, location: 1.0)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ), style: .init(lineWidth: 1))
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 2)
                
                Text(title)
                    .foregroundStyle(Color.hbTextPrimary)
                    .font(.hbSubtitle)
            }
        }
        .frame(height: 90)
    }
}
