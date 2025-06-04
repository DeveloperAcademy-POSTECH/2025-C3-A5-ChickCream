//
//  OnboardingPageView.swift
//  HeeBob
//
//  Created by 임영택 on 6/3/25.
//

import SwiftUI

struct OnboardingPageView: View {
    let content: OnboardingContent
    let showingForegroundImage: Bool
    
    var body: some View {
        Group {
            if let foregroundImageName =  content.foregroundImageName {
                VStack {
                    Text(content.title)
                        .multilineTextAlignment(.center)
                        .font(.hbTitle)
                        .foregroundStyle(Color.hbTextPrimary)
                        .padding(.vertical, 72)
                    
                    ZStack(alignment: .center) {
                        if showingForegroundImage {
                            Image(content.backgroundImageName)
                                .resizable()
                                .frame(maxWidth: UIScreen.main.bounds.width)
                                .scaledToFit()
                                .clipped()
                            
                            Image(foregroundImageName)
                                .resizable()
                                .frame(maxWidth: UIScreen.main.bounds.width)
                                .scaledToFit()
                                .clipped()
                        } else {
                            Image(content.backgroundImageName)
                                .resizable()
                                .frame(maxWidth: UIScreen.main.bounds.width)
                                .scaledToFit()
                                .clipped()
                        }
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
