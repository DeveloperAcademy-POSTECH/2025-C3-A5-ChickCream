//
//  HBBackground.swift
//  HeeBob
//
//  Created by 임영택 on 6/11/25.
//

import SwiftUI

struct HBBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color.hbBackground.ignoresSafeArea()
            
            content
        }
    }
}

extension View {
    public func hbBackground() -> some View {
        modifier(HBBackgroundModifier())
    }
}
