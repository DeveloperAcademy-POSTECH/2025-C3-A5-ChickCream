//
//  QuestionOptionButton.swift
//  HeeBob
//
//  Created by 임영택 on 6/3/25.
//

import SwiftUI

struct QuestionOptionButton: View {
    let title: String
    let type: QuestionOptionButtonType
    let isDisabled: Bool
    let didTap: () -> Void
    
    var body: some View {
        Button {
            didTap()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(isDisabled ? Color.clear : Color.hbPrimaryLighten)
                    .stroke(isDisabled ? Color.hbDisabled : Color.hbPrimary, style: .init(lineWidth: 3))
                    .frame(width: 173, height: type == .half ? 160 : 144 )
                
                Text(title)
                    .font(.hbSubtitle)
                    .foregroundStyle(isDisabled ? Color.hbDisabled : Color.hbPrimary)
            }
        }

    }
    
    enum QuestionOptionButtonType {
        case half
        case quarter
    }
}
