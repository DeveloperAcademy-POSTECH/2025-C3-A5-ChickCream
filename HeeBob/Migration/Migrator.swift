//
//  Migrator.swift
//  HeeBob
//
//  Created by 임영택 on 5/31/25.
//

import Foundation
import SwiftData
import OSLog

actor Migrator {
    let modelContainer: ModelContainer
    let rawDataFileName = "db"
    let logger = Logger.category("Migrator")
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    func migrate() throws {
        guard let entityList = loadDietList() else {
            return
        }
        
        try withContext { context in
            entityList.forEach { raw in
                context.insert(raw.toEntity())
                logger.info("인서트 완료: \(raw.title)")
            }
        }
        
        logger.info("✅ 데이터 마이그레이션을 완료했습니다")
    }
    
    func withContext(_ job: (ModelContext) throws -> Void) throws {
        let modelContext = ModelContext(modelContainer)
        try job(modelContext)
        try modelContext.save()
    }
    
    func loadDietList() -> [RawDataEntry]? {
        guard let rawDataPath = Bundle.main.url(forResource: rawDataFileName, withExtension: "json") else {
            logger.error("❌ 데이터 파일을 찾을 수 없습니다")
            fatalError("데이터 파일을 찾을 수 없습니다")
        }
        
        do {
            let rawData = try Data(contentsOf: rawDataPath)
            let serializer = JSONDecoder()
            return try serializer.decode([RawDataEntry].self, from: rawData).sorted { $0.title < $1.title }
        } catch {
            logger.error("❌ 데이터 파일을 불러오던 중 오류가 발생했습니다: \(error)")
            return nil
        }
    }
}
