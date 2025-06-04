//
//  ResultsView.swift
//  HeeBob
//
//  Created by BoMin Lee on 5/31/25.
//

import SwiftUI
import SwiftData

struct ResultsView: View {
    let userAnswer: UserAnswer
    
    @Environment(\.modelContext) var modelContext
    
    @State private var activeID: String?
    @State private var selectedIndex: Int = 0
    @State private var carouselItems: [CarouselItem] = []
    @State private var fetchedFoodIDs: Set<UUID> = []
    
    var body: some View {
        VStack {
            UserAnswerView(
                userAnswer: userAnswer,
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
                data: carouselItems
            ) { item in
                switch item {
                case .food(let food):
                    ResultCard(food: food) {
                        // TODO: 메뉴 상세 보기 연결
                    }
                case .addCard:
                    AddCard {
                        loadOneMoreRecommendation()
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
        .onAppear {
            loadInitialRecommendations()
        }
        .HBNavigationBar(centerView: {
            Text("추천 결과")
                .font(.hbTitle)
                .foregroundStyle(Color.hbTextPrimary)
        })
        .HBNavigationBarBackButtonHidden(true)
    }
}

/// 음식 조건 및 SwiftData에서 가져오는 로직들
extension ResultsView {
    func loadInitialRecommendations() {
        do {
            let foods = try fetchMatchingFoods(limit: 3)
            fetchedFoodIDs.formUnion(foods.map { $0.id })
            updateCarouselItems(with: foods)
        } catch {
            print("❌ Initial fetch failed: \(error)")
            self.carouselItems = [.addCard]
        }
    }
    
    func loadOneMoreRecommendation() {
        do {
            let newFoods = try fetchMatchingFoods(limit: 1, excluding: fetchedFoodIDs)
            guard let food = newFoods.first else { return }
            fetchedFoodIDs.insert(food.id)
            insertFoodBeforeAddCard(food)
        } catch {
            print("❌ Failed to load one more food: \(error)")
        }
    }
    
    private func fetchMatchingFoods(limit: Int, excluding excludedIDs: Set<UUID> = []) throws -> [Food] {
        let portableAnswer = userAnswer.isPortable
        let cookableAnswer = userAnswer.isCookable
        let mainIngredientAnswer = userAnswer.mainIngredient.rawValue
        
        let descriptor = FetchDescriptor<Food>(
            predicate: #Predicate { food in
                food.attribute.isPortable == portableAnswer &&
                food.attribute.isCookable == cookableAnswer &&
                food.attribute._mainIngredient == mainIngredientAnswer &&
                !excludedIDs.contains(food.id)
            }
        )
        let matchingFoods = try modelContext.fetch(descriptor)
        return Array(matchingFoods.shuffled().prefix(limit))
    }

    private func updateCarouselItems(with foods: [Food]) {
        self.carouselItems = foods.map { .food($0) } + [.addCard]
    }
    
    private func insertFoodBeforeAddCard(_ food: Food) {
        let index = max(carouselItems.count - 1, 0)
        carouselItems.insert(.food(food), at: index)
    }
}
