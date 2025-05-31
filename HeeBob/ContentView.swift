//
//  ContentView.swift
//  HeeBob
//
//  Created by 임영택 on 5/28/25.
//

import SwiftUI
import SwiftData
import OSLog

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State var isLoading: Bool = false
    
    let logger = Logger.category("ContentView")
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else {
                TestView()
            }
        }
        .onAppear {
            viewDidAppear()
        }
    }
}

extension ContentView {
    private func viewDidAppear() {
        migrateData()
    }
    
    private func migrateData() {
        guard getIsMigrated() == false else {
            logger.info("✔️ 이미 마이그레이션이 되어있습니다")
            return
        }
        
        isLoading = true
        let migrator = Migrator(modelContainer: modelContext.container)
        Task.detached {
            try await migrator.migrate()
            
            await MainActor.run {
                setIsMigrated()
                isLoading = false
            }
        }
    }
    
    private func getIsMigrated() -> Bool {
        UserDefaults.standard.bool(forKey: UserDefaultsKey.migrateSucceeded.rawValue)
    }
    
    private func setIsMigrated() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKey.migrateSucceeded.rawValue)
    }
}

#Preview {
    ContentView()
}
