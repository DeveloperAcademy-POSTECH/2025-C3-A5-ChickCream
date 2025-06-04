//
//  ToggleTestView.swift
//  HeeBob
//
//  Created by 산들 on 6/4/25.
//

import SwiftUI

struct ToggleTestView: View {
    @State var toggleIsOn = false
    
    var body: some View {
        Toggle(isOn: $toggleIsOn) {
            Text("asdfasdf")
        }
        .toggleStyle(CheckboxToggleStyle())
        .onChange(of: toggleIsOn) { oldValue, newValue in
            print(toggleIsOn)
        }
    }
}

#Preview {
    ToggleTestView()
}
