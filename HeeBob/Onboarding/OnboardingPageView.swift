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
                            .frame(maxWidth: UIScreen.main.bounds.width)
                            .clipped()
                        
                        Image(foregroundImageName)
                            .frame(maxWidth: UIScreen.main.bounds.width)
                            .clipped()
                    } else {
                        Image(content.backgroundImageName)
                            .frame(maxWidth: UIScreen.main.bounds.width)
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
}
