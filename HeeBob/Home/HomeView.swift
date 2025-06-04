//
//  HomeView.swift
//  HeeBob
//
//  Created by 임영택 on 6/3/25.
//

import SwiftUI
import Lottie

struct HomeView: View {
    let onboardingButtonColor = Color(hex: "#1C1B1F")
    
    var body: some View {
        ZStack {
            LinearGradient(
                stops: [
                    .init(color: .init(hex: "#F9AC80"), location: 0.0),
                    .init(color: .init(hex: "#FF6933"), location: 1.0),
                ],
                startPoint: UnitPoint(x: 0.33, y: 0),
                endPoint: UnitPoint(x: 0.66, y: 1.0)
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("희밥")
                        .font(.hbTitle)
                    
                    Spacer()
                    
                    Button {
                        print("온보딩 보기") // TODO: Navigate
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(onboardingButtonColor)
                            .frame(width: 24, height: 24)
                    }
                }
                .padding(24)
                
                LottieView(animation: .named("home"))
                    .playing(loopMode: .loop)
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal, 36)
                
                VStack(spacing: 16) {
                    HomeButton(title: "메뉴 추천받기") {
                        print("메뉴 추천")
                    }
                    
                    HomeButton(title: "찜한 메뉴 보러가기") {
                        print("찜한 메뉴")
                    }
                }
                .padding(24)
            }
        }
    }
}

#Preview {
    HomeView()
}
