//
//  HomeView.swift
//  HeeBob
//
//  Created by 임영택 on 6/3/25.
//

import SwiftUI
import Lottie

struct HomeView: View {
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
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("희밥")
                        .font(.hbTitle)
                    
                    Spacer()
                    
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
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

struct HomeButton: View {
    let title: String
    let didTap: () -> Void
    
    let titleColor = Color(hex: "#000000")
    
    var body: some View {
        Button {
            didTap()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.hbPrimaryLighten)
                
                Text(title)
                    .foregroundStyle(titleColor)
                    .font(.hbSubtitle)
            }
        }
        .frame(height: 90)
    }
}

#Preview {
    HomeView()
}
