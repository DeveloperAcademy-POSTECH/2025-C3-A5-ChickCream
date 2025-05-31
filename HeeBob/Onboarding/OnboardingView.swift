//
//  OnboardingView.swift
//  HeeBob
//
//  Created by 임영택 on 5/31/25.
//

import SwiftUI

struct OnboardingView: View {
    @State var contents = OnboardingContent.contents
    @State var scrollPosition = ScrollPosition(id: 0) {
        didSet {
            
        }
    }
    @State var currentIndex: Int = 0
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(contents.indices, id: \.self) { index in
                        VStack {
                            Text(contents[index].title)
                                .multilineTextAlignment(.center)
                                .font(.hbTitle)
                                .foregroundStyle(Color.hbTextPrimary)
                                .padding(.vertical, 72)
                            
                            if let imageName = contents[index].imageName {
                                Image(imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 256) // TODO: 하이파이 완료 후 사이즈 픽스
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 256)
                            }
                            
                            Spacer()
                        }
                        .id(index)
                        .frame(width: UIScreen.main.bounds.width - 32)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition($scrollPosition)
            .scrollTargetBehavior(.viewAligned)
            
            OnboardingPageIndicator(count: contents.count, currentPage: $currentIndex)
                .padding(.bottom, 40)
            
            OnboardingNextButton(title: currentIndex == contents.count - 1 ? "메뉴 추천 받으러가기" : "다음") {
                guard currentIndex < contents.count - 1 else {
                    return
                }
                
                scrollPosition = ScrollPosition(id: currentIndex + 1)
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
        
        .padding(16)
    }
}

struct OnboardingContent {
    let title: String
    let imageName: String?
    
    static let contents: [OnboardingContent] = [ // TODO: 하이파이 완료 후 이미지 추가
        .init(title: "아버지의 기준에 맞춰\n한 분만을 위한 메뉴를 선정했어요", imageName: nil),
        .init(title: "오래 씹으면 맛이 변하는\n밀가루 음식은 제외했어요", imageName: nil),
        .init(title: "너무 자극적이거나\n심하게 매운 음식도 제외했어요", imageName: nil),
        .init(title: "속에서 다시 뭉칠 수 있는\n떡 종류도 제외했답니다", imageName: nil),
        .init(title: "앞으로의 메뉴 고민은\n희밥이 도와드릴게요", imageName: nil),
    ]
}

#Preview {
    OnboardingView()
}
