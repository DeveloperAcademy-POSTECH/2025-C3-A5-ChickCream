//
//  OnboardingView.swift
//  HeeBob
//
//  Created by 임영택 on 5/31/25.
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

struct OnboardingView: View {
    @State var contents = OnboardingContent.contents
    @State var scrollPosition = ScrollPosition(id: 0)
    @State var currentIndex: Int = 0 {
        didSet {
            showingForegroundImage = true
        }
    }
    @State var showingForegroundImage = true
    
    var body: some View {
        ZStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(contents.indices, id: \.self) { index in
                        OnboardingPageView(content: contents[index], showingForegroundImage: showingForegroundImage)
                        .id(index)
                        .frame(width: UIScreen.main.bounds.width)
                        .background(contents[index].backgroundColor)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition($scrollPosition)
            .scrollTargetBehavior(.viewAligned)
            
            VStack(spacing: 0) {
                Spacer()
                
                OnboardingPageIndicator(count: contents.count, currentPage: $currentIndex)
                    .padding(.bottom, 40)
                
                OnboardingNextButton(title: currentIndex == contents.count - 1 ? "메뉴 추천 받으러가기" : "다음") {
                    guard currentIndex < contents.count - 1 else {
                        return
                    }
                    
                    scrollPosition = ScrollPosition(id: currentIndex + 1)
                    
                    showingForegroundImage = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            showingForegroundImage = false
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .onChange(of: currentIndex, { oldValue, newValue in
            scrollPosition = ScrollPosition(id: newValue)
        })
        .onChange(of: scrollPosition, { oldValue, newValue in
            if let currentIndex = scrollPosition.viewID as? Int?,
               let currentIndex = currentIndex {
                self.currentIndex = currentIndex
            }
        })
    }
}

struct OnboardingContent {
    let title: String
    let foregroundImageName: ImageResource?
    let backgroundImageName: ImageResource
    let backgroundColor: Color
    
    static let contents: [OnboardingContent] = [
        .init(
            title: "아버지의 기준에 맞춰\n한 분만을 위한 메뉴를 선정했어요",
            foregroundImageName: nil,
            backgroundImageName: .onboardingTextBackground,
            backgroundColor: .hbBackground
        ),
        .init(
            title: "오래 씹으면 맛이 변하는\n밀가루 음식은 제외했어요",
            foregroundImageName: .onboardingPage1Foreground,
            backgroundImageName: .onboardingPage1Background,
            backgroundColor: .init(hex: "FFF8EF")
        ),
        .init(
            title: "너무 자극적이거나\n심하게 매운 음식도 제외했어요",
            foregroundImageName: .onboardingPage2Foreground,
            backgroundImageName: .onboardingPage2Background,
            backgroundColor: .init(hex: "FFF4F0")
        ),
        .init(
            title: "속에서 다시 뭉칠 수 있는\n떡 종류도 제외했답니다",
            foregroundImageName: .onboardingPage3Foreground,
            backgroundImageName: .onboardingPage3Background,
            backgroundColor: .init(hex: "F2F6EE")
        ),
        .init(
            title: "앞으로의 메뉴 고민은\n희밥이 도와드릴게요",
            foregroundImageName: nil,
            backgroundImageName: .onboardingTextBackground,
            backgroundColor: .hbBackground
        ),
    ]
}

#Preview {
    OnboardingView()
}
