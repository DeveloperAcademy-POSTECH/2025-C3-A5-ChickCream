//
//  Color+.swift
//  HeeBob
//
//  Created by BoMin Lee on 5/31/25.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (without alpha)
            (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 1) // Default to white in case of an error
        }
        self.init(
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255
        )
    }
    
    func toHex() -> String? {
        let uiColor = UIColor(self)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        guard uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) else {
            return nil
        }
        
        let rgb: Int = (Int)(r * 255) << 16 |
        (Int)(g * 255) << 8 |
        (Int)(b * 255) << 0
        
        return String(format: "%06X", rgb)
    }
    
    // 16진수 색상코드 가져와서 커스텀 컬러 지정
    static let hbPrimary = Color(hex: "#FF5A18")
    static let hbHighlight = Color(hex: "#FFA76C")
    static let hbPrimaryLighten = Color(hex: "#FFDBCC")
    static let hbTextPrimary = Color(hex: "#4E2B1A")
    static let hbTextSecondary = Color(hex: "#7A5C48")
    static let hbButtonSecondary = Color(hex: "#C7BFB8")
    static let hbDisabled = Color(hex: "#D6D1CB")
    static let hbBackground = Color(hex: "#FFFDF9")
//    static let hbWhite = Color(hex: "#FCFAF8") // 확정 아니라서 주석 처리해두었습니다.
}
