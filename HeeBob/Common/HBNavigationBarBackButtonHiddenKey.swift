//
//  HBNavigationBarBackButtonHiddenKey.swift
//  HeeBob
//
//  Created by BoMin Lee on 6/2/25.
//

import SwiftUI

private struct HBNavigationBarBackButtonHiddenKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    var hbNavigationBarBackButtonHidden: Bool {
        get { self[HBNavigationBarBackButtonHiddenKey.self] }
        set { self[HBNavigationBarBackButtonHiddenKey.self] = newValue }
    }
}
