//
//  ResultsView.swift
//  HeeBob
//
//  Created by BoMin Lee on 5/31/25.
//

import SwiftUI

struct ResultsView: View {
    @State private var activeID: String?
    let carouselItems: [CarouselItem] = foods.map { .food($0) } + [.addCard]
    
    var body: some View {
        VStack {
            ResultsCarousel(config: .init(hasScale: true, cardWidth: UIScreen.main.bounds.width*0.81),
                            selection: $activeID,
                            data: carouselItems) { item in
                switch item {
                case .food(let food):
                    ResultCard(food: food) {
                        print(food.title)
                    }
                case .addCard:
                    AddCard {
                        print("아이템 추가 누름")
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height*0.4)
            
            VStack {
                HStack {
                    Button {
                        
                    } label: {
                        Text("찜한 메뉴")
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("홈")
                    }

                }
                .padding()
            }
        }
    }
}



#Preview {
    ResultsView()
}
