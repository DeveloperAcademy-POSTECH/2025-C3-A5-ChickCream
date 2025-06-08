//
//  FontManager.swift
//  HeeBob
//
//  Created by BoMin Lee on 5/31/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Suite {
        case bold
        case extraBold
        case heavy
        case light
        case medium
        case regular
        case semibold
        
        var value: String {
            switch self {
            case .bold:
                return "SUITE-Bold"
            case .extraBold:
                return "SUITE-ExtraBold"
            case .heavy:
                return "SUITE-Heavy"
            case .light:
                return "SUITE-Light"
            case .medium:
                return "SUITE-Medium"
            case .regular:
                return "SUITE-Regular"
            case .semibold:
                return "SUITE-SemiBold"
            }
        }
    }
    
    static func suite(type: Suite, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static var hbTitle: Font {
        return .suite(type: .extraBold, size: 26)
    }
    
    static var hbSubtitle: Font {
        return .suite(type: .extraBold, size: 24)
    }
    
    static var hbBody1: Font {
        return .suite(type: .semibold, size: 20)
    }
    
    static var hbBody2: Font {
        return .suite(type: .semibold, size: 17)
    }
    
    static var hbMinimum: Font {
        return .suite(type: .extraBold, size: 16)
    }
}
