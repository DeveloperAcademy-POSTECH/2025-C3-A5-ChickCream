//
//  QuestionTitleView.swift
//  HeeBob
//
//  Created by 임영택 on 6/3/25.
//

import SwiftUI

struct QuestionTitleView: View {
    let content: String
    
    init(_ content: String) {
        self.content = content
    }
    
    var body: some View {
        Text(content)
            .font(.hbTitle)
            .foregroundStyle(Color.hbTextPrimary)
            .lineSpacing(1.4)
            .multilineTextAlignment(.center)
    }
}
