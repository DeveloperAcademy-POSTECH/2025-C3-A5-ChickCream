//
//  CheckboxToggleStyle.swift
//  HeeBob
//
//  Created by 산들 on 6/4/25.
//

import Foundation
import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(configuration.isOn ? Color.hbPrimary : Color.hbDisabled)
                configuration.label
            }
        }
        .buttonStyle(.plain)
    }
}
