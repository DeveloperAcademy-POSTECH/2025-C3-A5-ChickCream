//
//  ResultsView.swift
//  HeeBob
//
//  Created by BoMin Lee on 5/31/25.
//

import SwiftUI
import SwiftData

struct ResultsView: View {
    @EnvironmentObject var router: NavigationRouter

    let userAnswer: UserAnswer
    
    @Environment(\.modelContext) var modelContext
    
    @State private var hasLoaded = false
    
    @State private var activeID: String?
    @State private var selectedIndex: Int = 0
    @State private var selectedItemID: UUID?
    @State private var carouselItems: [CarouselItem] = []
    @State private var fetchedFoodIDs: Set<UUID> = []
    @State private var resultFoods: [Food] = []
    
    private let cardWidth = UIScreen.main.bounds.width * 0.816
    private let cardHeight = UIScreen.main.bounds.height * 0.37
    
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
            resultCarouselView
            cardNumberView
            Spacer()
            HStack {
                HBButton(configuration: .init(
                    title: "찜한 메뉴",
                    foregroundColor: .hbPrimary,
                    backgroundColor: .hbPrimaryLighten
                )) {
                    router.push(.favorite)
                }
                Spacer()
                HBButton(configuration: .init(
                    title: "다시 추천받기",
                    foregroundColor: .hbPrimary,
                    backgroundColor: .hbPrimaryLighten
                )) {
                    hasLoaded = false
                    /// fixme: 뷰모델을 초기화하는 방법 고민
                    router.pop()
                    router.pop()
                    router.push(.question(id: UUID()))
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 27)
        }
        .onAppear {
            if !hasLoaded {
                loadInitialRecommendations()
                hasLoaded = true
            }
        }
        .HBNavigationBar(centerView: {
            Text("추천 결과")
                .font(.hbTitle)
                .foregroundStyle(Color.hbTextPrimary)
        })
        .HBNavigationBarBackButtonHidden(false)
    }
}

extension ResultsView {
    private var resultCarouselView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(carouselItems) { item in
                    switch item {
                    case .food(let food):
                        ResultCard(food: food) {
                            router.push(.detail(food: food))
                        }
                        .id(item.id)
                        .scrollTransition(){ content, phase in
                            content
                                .scaleEffect(x: phase.isIdentity ? 1 : 0.8,
                                             y: phase.isIdentity ? 1 : 0.8)
                        }
                        .frame(maxHeight: 320)
                        .aspectRatio(CGSize(width: 321, height: 316), contentMode: .fit)
                    case .addCard:
                        AddCard {
                            loadOneMoreRecommendation()
                        }
                        .id(item.id)
                        .scrollTransition(){ content, phase in
                            content
                                .scaleEffect(x: phase.isIdentity ? 1 : 0.8,
                                             y: phase.isIdentity ? 1 : 0.8)
                        }
                        .frame(maxHeight: 320)
                        .aspectRatio(CGSize(width: 321, height: 316), contentMode: .fill)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.vertical, 16, for: .scrollContent)
        .contentMargins(.horizontal, 36, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned) // 카드 중간 focus
        .scrollPosition(id: $selectedItemID)
        .onChange(of: selectedItemID) {
            if let id = selectedItemID,
               let index = carouselItems.firstIndex(where: { $0.id == id }) {
                selectedIndex = index
            }
        }
    }
    
    private var cardNumberView: some View {
        HStack {
            Spacer()
            Text("\(selectedIndex + 1)/\(carouselItems.count)")
                .font(.hbBody1)
                .foregroundStyle(Color.hbTextSecondary)
            Spacer()
        }
    }
}

/// 음식 조건 및 SwiftData에서 가져오는 로직들
extension ResultsView {
    func loadInitialRecommendations() {
        do {
            let foods = try fetchMatchingFoods(limit: 3)
            fetchedFoodIDs.formUnion(foods.map { $0.id })
            resultFoods = foods
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
