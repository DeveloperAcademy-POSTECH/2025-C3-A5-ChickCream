//
//  ResultLoadingView.swift
//  HeeBob
//
//  Created by BoMin Lee on 6/4/25.
//

import SwiftUI
import Lottie

struct ResultLoadingView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.hbBackground.edgesIgnoringSafeArea(.all)
            VStack(spacing: 64) {
                Text("메뉴 찾는 중...")
                    .font(.hbSubtitle)
                    .foregroundStyle(Color.hbTextPrimary)
                ZStack {
                    Image(.commonTextBackground)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 0)
                    LottieView(animation: .named("loading"))
                        .looping()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
        .onAppear {
            Task {
                try? await Task.sleep(nanoseconds: 5_000_000_000) // 5초
                dismiss()
            }
        }
    }
}

#Preview {
    ResultLoadingView()
}
