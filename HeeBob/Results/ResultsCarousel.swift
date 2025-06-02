//
//  ResultsCarousel.swift
//  HeeBob
//
//  Created by BoMin Lee on 5/31/25.
//

import SwiftUI

struct ResultsCarousel<Content: View, Data: RandomAccessCollection>: View where Data.Element: Identifiable {
    var config: Config
    @Binding var selection: Data.Element.ID?
    var data: Data
    @ViewBuilder var content: (Data.Element) -> Content
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ScrollView(.horizontal) {
                HStack(spacing: config.spacing) {
                    ForEach(data) { item in
                        ItemView(item)
                            .border(.red, width: 3)
                    }
                }
                .scrollTargetLayout()
                
            }
            .safeAreaPadding(.horizontal, max((size.width - config.cardWidth) / 2, 0)) // 중앙에서 시작하고 끝내기 위함
            .scrollPosition(id: $selection) // Position 고정하기 위함
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            .scrollIndicators(.hidden)
        }
    }
    /// Item View
    @ViewBuilder
    func ItemView(_ item: Data.Element) -> some View {
        GeometryReader { proxy in            
            let frame = proxy.frame(in: .global) // 화면 전체 좌표계 기준
            let centerX = UIScreen.main.bounds.width / 2
            let distanceFromCenter = abs(frame.midX - centerX)
            
            let maxDistance = UIScreen.main.bounds.width / 2 + config.cardWidth
            let progress = min(distanceFromCenter / maxDistance, 1)
            let scaleValue = config.scaleValue * progress
            let scale = config.hasScale ? 1 - scaleValue : 1
            
            content(item)
                .aspectRatio(contentMode: .fit)
                .scaleEffect(scale)
                .animation(.easeOut(duration: 0.2), value: scale)
                .frame(width: config.cardWidth)
                .clipShape(RoundedRectangle(cornerRadius: config.cornerRadius))
        }
        .frame(width: config.cardWidth)
    }
    
    struct Config {
        var hasScale: Bool = true
        var scaleValue: CGFloat = 0.2
        
        var cardWidth: CGFloat = 150
        var spacing: CGFloat = 0
        var cornerRadius: CGFloat = 15
    }
}
