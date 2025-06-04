//
//  ResultsView.swift
//  HeeBob
//
//  Created by BoMin Lee on 5/31/25.
//

import SwiftUI
import SwiftData

struct ResultsView: View {
    @StateObject var viewModel: ResultsViewModel
    
    @State private var activeID: String?
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        VStack {
            UserAnswerView(
                userAnswer: viewModel.userAnswer,
                borderColor: .hbButtonSecondary,
                backgroundColor: .clear
            )
            .padding(.horizontal, 20)
            .padding(.top, 10)
            Spacer()
                .frame(height: 39)
            ResultsCarousel(
                config: .init(
                    hasScale: true,
                    cardWidth: UIScreen.main.bounds.width * 0.81
                ),
                selection: $activeID,
                selectedIndex: $selectedIndex,
                data: viewModel.carouselItems
            ) { item in
                switch item {
                case .food(let food):
                    ResultCard(food: food) {
                        // TODO: 메뉴 상세 보기 연결
                    }
                case .addCard:
                    AddCard {
                        Task {
                            await viewModel.loadOneMoreRecommendation()
                        }
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.38)
            Spacer()
            HStack {
                HBButton(configuration: .init(
                    title: "찜한 메뉴",
                    foregroundColor: .hbPrimary,
                    backgroundColor: .hbPrimaryLighten
                )) {
                    // TODO: 찜한 메뉴 연결
                }
                Spacer()
                HBButton(configuration: .init(
                    title: "다시 추천받기",
                    foregroundColor: .hbPrimary,
                    backgroundColor: .hbPrimaryLighten
                )) {
                    // TODO: 다시 추천 받기 연결
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 27)
        }
        .HBNavigationBar(centerView: {
            Text("추천 결과")
                .font(.hbTitle)
                .foregroundStyle(Color.hbTextPrimary)
        })
        .HBNavigationBarBackButtonHidden(true)
    }
}
