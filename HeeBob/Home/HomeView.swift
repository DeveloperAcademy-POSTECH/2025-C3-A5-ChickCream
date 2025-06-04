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
    @StateObject private var router = NavigationRouter()
    @State private var shouldShowOnboarding: Bool = false
    
    var body: some View {
        NavigationStack(path: $router.path) {
            Group {
                if shouldShowOnboarding {
                    OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
                } else {
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
                                    .foregroundStyle(Color.hbTextPrimary)
                                
                                Spacer()
                                
                                Button {
                                    shouldShowOnboarding = true
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
                                    router.push(.question)
                                }
                                
                                HomeButton(title: "찜한 메뉴 보러가기") {
                                    print("찜한 메뉴")
                                    router.push(.favorite)
                                }
                            }
                            .padding(24)
                        }
                    }
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .question:
                    QuestionView().environmentObject(router)
                case .loading:
                    ResultLoadingView().environmentObject(router)
                case .result(let userAnswer):
                    ResultsView(userAnswer: userAnswer).environmentObject(router)
                case .favorite:
                    FavoriteViewPlaceHolder().environmentObject(router)
                case .search:
                    SearchView().environmentObject(router)
                case .detail(let Food):
                    MenuDetailView(food: Food)
                        .environmentObject(router)
                }
            }
        }
        .onAppear {
            shouldShowOnboarding = !UserDefaults.standard.bool(forKey: UserDefaultsKey.onboardingShown.rawValue)
        }
        .environmentObject(router)
    }
}

#Preview {
    HomeView()
}
