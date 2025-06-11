//
//  HeeBobApp.swift
//  HeeBob
//
//  Created by 임영택 on 5/28/25.
//

import SwiftUI
import SwiftData

@main
struct HeeBobApp: App {
    let modelContainer = {
        do {
            let modelContainer = try ModelContainer(for: Food.self, FoodAttribute.self, Favorite.self)
            return modelContainer
        } catch {
            fatalError("SwiftData 컨테이너를 생성할 수 없습니다.")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}
