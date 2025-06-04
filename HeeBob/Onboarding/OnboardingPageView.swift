//
//  OnboardingPageView.swift
//  HeeBob
//
//  Created by 임영택 on 6/3/25.
//

import SwiftUI

struct OnboardingPageView: View {
    let content: OnboardingContent
    
    var body: some View {
        Group {
            if let foregroundImageName =  content.foregroundImageName {
                VStack(spacing: 0) {
                    Text(content.title)
                        .multilineTextAlignment(.center)
                        .font(.hbTitle)
                        .foregroundStyle(Color.hbTextPrimary)
                        .padding(.top, 72)
                    
                    ZStack(alignment: .center) {
                        Image(content.backgroundImageName)
                            .resizable()
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 450)
                            .scaledToFill()
                            .clipped()
                        
                        Image(foregroundImageName)
                            .resizable()
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 450)
                            .scaledToFill()
                            .clipped()
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
        .background(Color.hbBackground)
    }
}
