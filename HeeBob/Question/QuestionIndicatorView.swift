//
//  QuestionIndicatorView.swift
//  HeeBob
//
//  Created by 임영택 on 6/1/25.
//

import SwiftUI

struct QuestionIndicatorView: View {
    /// 마지막 페이지 번호
    let lastPage: Int
    
    /// 현재 페이지 번호 (1부터 시작)
    let currentPage: Int
    
    let padding: CGFloat = 16
    
    var oneIndicatorWidth: CGFloat {
        return (UIScreen.main.bounds.width - padding * 2) / CGFloat(lastPage)
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.hbPrimary)
                .frame(width: oneIndicatorWidth * CGFloat(currentPage), height: 7)
            
            ForEach(currentPage..<lastPage, id: \.self) { _ in
                Rectangle()
                    .fill(Color.hbButtonSecondary)
                    .frame(width: oneIndicatorWidth, height: 1)
            }
        }
        .animation(.easeInOut, value: currentPage)
        .animation(.easeInOut, value: lastPage)
    }
}

#Preview {
    struct PreviewContainer: View {
        @State var lastPage: Int = 5
        @State var currentPage: Int = 1
        
        var body: some View {
            Button {
                lastPage += 1
            } label: {
                Text("전체 페이지 증가")
            }
            
            Button {
                if currentPage > 0 && currentPage < lastPage {
                    currentPage += 1
                }
            } label: {
                Text("현재 페이지 증가")
            }

            
            QuestionIndicatorView(lastPage: lastPage, currentPage: currentPage)
        }
    }
    
    return PreviewContainer()
}
