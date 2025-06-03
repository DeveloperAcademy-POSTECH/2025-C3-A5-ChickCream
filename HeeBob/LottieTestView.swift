//
//  LottieTestView.swift
//  HeeBob
//
//  Created by 임영택 on 6/3/25.
//

import SwiftUI
import Lottie

struct LottieTestView: View {
    var loadingLottieURL1: URL? {
        Bundle.main.url(forResource: "loading_animation", withExtension: "json")
    }
    
    var loadingLottieURL2: URL? {
        Bundle.main.url(forResource: "rocket_animation", withExtension: "json")
    }
    
    var loadingLottieURL3: URL? {
        Bundle.main.url(forResource: "home_lottie2", withExtension: "json")
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                stops: [
                    .init(color: .init(hex: "#F9AC80"), location: 0.0),
                    .init(color: .init(hex: "#FF6933"), location: 1.0),
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                if let url = loadingLottieURL3 {
                    LottieView {
                        try! await LottieAnimation.loadedFrom(url: url)
                    }
                    .playing(loopMode: .loop)
                    .padding(48)
                }
            }
        }
    }
}

#Preview {
    LottieTestView()
}
