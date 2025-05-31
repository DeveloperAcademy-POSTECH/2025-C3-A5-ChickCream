//
//  Logger+.swift
//  HeeBob
//
//  Created by 임영택 on 5/31/25.
//

import Foundation
import OSLog

extension Logger {
    static func category(_ category: String) -> Logger {
        .init(subsystem: Bundle.main.bundleIdentifier ?? "com.chickcream.HeeBob", category: category)
    }
}
