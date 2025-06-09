//
//  FilterSectionView.swift
//  HeeBob
//
//  Created by 산들 on 6/4/25.
//

import SwiftUI

struct FilterSectionView: View {
    let title: String
    var buttons: [FilterButton]
    @Binding var selectedValue: Bool?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.hbSubtitle)
                .foregroundStyle(Color.hbTextPrimary)
                .padding(.bottom, 8)
                .padding(.leading, 16)
            
            Divider() // FIXME: 왜 이거 안보임?
            
            ForEach(buttons, id: \.title) { button in
                Button {
                    // 선택 값 업데이트 + 액션 실행
                    selectedValue = button.value
                    button.action(button.value)
                } label: {
                    HStack {
                        Text(button.title)
                        
                        Spacer()
                        // checkMark 추가
                        if selectedValue == button.value {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color.hbPrimary)
                                .padding(.trailing, 16)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.hbBody2)
                    .padding(.top, 8)
                    .padding(.bottom, 0)
                    .padding(.leading, 16)
                    .foregroundStyle(
                        selectedValue == button.value ? Color.hbPrimary : Color.hbTextPrimary
                    )
                    .contentShape(Rectangle())
                    
                }
                .padding(.vertical, 8)
            }
            
        }
    }
}
