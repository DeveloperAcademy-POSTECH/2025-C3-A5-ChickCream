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
    }
}

#Preview {
    QuestionIndicatorView(lastPage: 5, currentPage: 1)
}
