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
    @Binding var selectedIndex: Int
    var data: Data
    @ViewBuilder var content: (Data.Element) -> Content
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let scrollViewCenterX = geometry.frame(in: .global).midX
            
            VStack {
                ScrollView(.horizontal) {
                    HStack(spacing: config.spacing) {
                        ForEach(Array(data.enumerated()), id: \.1.id) { index, item in
                            ItemView(item, index: index)
                        }
                    }
                    .scrollTargetLayout()
                }
                .safeAreaPadding(.horizontal, max((size.width - config.cardWidth) / 2, 0)) // 중앙에서 시작하고 끝내기 위함
                .scrollPosition(id: $selection) // Position 고정하기 위함
                .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
                .scrollIndicators(.hidden)
                .onPreferenceChange(ItemCenterPreferenceKey.self) { centers in
                    /// 중앙과 가장 가까운 인덱스 찾기
                    let closest = centers.min(by: { abs($0.value - scrollViewCenterX) < abs($1.value - scrollViewCenterX) })
                    if let closestIndex = closest?.key, selectedIndex != closestIndex {
                        DispatchQueue.main.async {
                            selectedIndex = closestIndex
                        }
                    }
                }
                
                Text("\(selectedIndex+1)/\(data.count)")
                    .font(.hbBody1)
                    .foregroundStyle(Color.hbTextSecondary)
            }
        }
    }
    /// Item View
    @ViewBuilder
    func ItemView(_ item: Data.Element, index: Int) -> some View {
        GeometryReader { proxy in
            let frame = proxy.frame(in: .global) // 화면 전체 좌표계 기준
            let centerX = UIScreen.main.bounds.width / 2
            let centerX2 = frame.midX
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
                .anchorPreference(
                    key: ItemCenterPreferenceKey.self,
                    value: .center
                ) { _ in [index: centerX2] }
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

struct ItemCenterPreferenceKey: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]
    static func reduce(value: inout [Int: CGFloat], nextValue: () -> [Int: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}
