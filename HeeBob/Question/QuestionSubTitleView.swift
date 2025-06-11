//
//  QuestionSubTitleView.swift
//  HeeBob
//
//  Created by 임영택 on 6/3/25.
//

import SwiftUI

struct QuestionSubTitleView: View {
    let content: String
    
    init(_ content: String) {
        self.content = content
    }
    
    var body: some View {
        Text(content)
            .font(.hbMinimum)
            .foregroundStyle(Color.hbTextSecondary)
            .multilineTextAlignment(.center)
            .lineSpacing(1.5)
    }
}
