//
//  OnboardingPageView.swift
//  HeeBob
//
//  Created by 임영택 on 6/3/25.
//

import SwiftUI
import Lottie

struct OnboardingPageView: View {
    let content: OnboardingContent
    let isLottiePlaying: Bool
    
    var body: some View {
        Group {
            if let lottieAnimation =  content.lottieAnimation {
                VStack {
                    Text(content.title)
                        .multilineTextAlignment(.center)
                        .font(.hbTitle)
                        .foregroundStyle(Color.hbTextPrimary)
                        .padding(.vertical, 72)
                    
                    ZStack(alignment: .center) {
                        Image(content.backgroundImageName)
                            .resizable()
                            .frame(maxWidth: UIScreen.main.bounds.width)
                            .scaledToFit()
                            .clipped()
                        
                        LottieView(animation: lottieAnimation)
                            .playbackMode(isLottiePlaying ? .playing(.fromProgress(0, toProgress: 1, loopMode: .loop)) : .paused(at: .progress(0)))
                    }
                    
                    Spacer()
                }
            } else {
                VStack {
                    Spacer()
                    
                    ZStack {
                        Image(content.backgroundImageName)
                            .resizable()
                            .scaledToFit()
                        
                        Text(content.title)
                            .multilineTextAlignment(.center)
                            .font(.hbTitle)
                            .foregroundStyle(Color.hbTextPrimary)
                    }
                    
                    Spacer()
                }
            }
        }
        .background(backgroundView(for: content.backgroundColor).ignoresSafeArea())
    }
    
    @ViewBuilder
    func backgroundView(for style: any ShapeStyle) -> some View {
        if let color = style as? Color {
            color
        } else if let gradient = style as? LinearGradient {
            gradient
        }
    }
}
