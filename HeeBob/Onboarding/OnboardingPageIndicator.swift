//
//  OnboardingPageIndicator.swift
//  HeeBob
//
//  Created by 임영택 on 5/31/25.
//

import SwiftUI

struct OnboardingPageIndicator: View {
    let count: Int
    @Binding var currentPage: Int
    
    let circleSize: CGFloat = 10
    let padding: CGFloat = 2
    
    var frameWidth: CGFloat {
        circleSize * CGFloat(count - 1)
        + circleSize * 2 // 캡슐
        + padding * 4 * CGFloat(count)
        + 24
    }
    
    var body: some View {
        HStack {
            ForEach(0..<count, id: \.self) { index in
                if index == currentPage {
                    Capsule()
                        .fill(Color.hbPrimary)
                        .frame(width: circleSize * 2, height: circleSize)
                        .padding(.horizontal, padding)
                        .gesture(DragGesture()
                            .onEnded { gesture in
                                handleDragOffsetChanged(gesture.translation.width)
                            }
                        )
                } else {
                    Button {
                        currentPage = index
                    } label: {
                        Circle()
                            .fill(Color.hbDisabled)
                    }
                    .frame(width: circleSize, height: circleSize)
                    .padding(.horizontal, padding)
                }
            }
        }
        .animation(.bouncy, value: currentPage)
        .frame(width: frameWidth)
        .contentShape(Rectangle())
    }
}

extension OnboardingPageIndicator {
    private func handleDragOffsetChanged(_ offset: CGFloat) {
        let movedOffset = abs(offset)
        let direction = offset > 0 ? 1 : -1
        let movedPage =
        Int(round(movedOffset)) / Int(circleSize + padding * 2 * 1.5) * direction // 현재 인덱스 계산
        
        if currentPage + movedPage < 0 {
            currentPage = 0
            // print("calculated page is less than 0 \(currentPage + movedPage)")
            return
        }
        
        if currentPage + movedPage >= count {
            currentPage = count - 1
            // print("calculated page is out of range \(currentPage + movedPage)")
            return
        }
        currentPage += movedPage
        // print("currentPage = \(currentPage)")
    }
}

#Preview {
    struct Preview: View {
        @State var currentPage = 0
        var body: some View {
            OnboardingPageIndicator(count: 5, currentPage: $currentPage)
        }
    }
    return Preview()
}
