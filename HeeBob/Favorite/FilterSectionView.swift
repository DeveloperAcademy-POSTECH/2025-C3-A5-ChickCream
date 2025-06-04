//
//  FilterSectionView.swift
//  HeeBob
//
//  Created by 산들 on 6/4/25.
//

import SwiftUI

struct FilterSectionView: View {
    let title: String
    let buttons: [FilterButton]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .padding()
            Divider()
            
            ForEach(buttons, id: \.title) { button in
                Button {
                    button.action(button.value)
                } label: {
                    Text(button.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                }
                .padding(.vertical, 8)
            }
        }
    }
}
