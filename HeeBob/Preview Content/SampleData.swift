//
//  SampleData.swift
//  HeeBob
//
//  Created by 임영택 on 6/1/25.
//

import Foundation
import SwiftUI
import SwiftData

/// ref: https://developer.apple.com/documentation/coredata/adopting-swiftdata-for-a-core-data-app
struct SampleData: PreviewModifier {
    static func makeSharedContext() throws -> ModelContainer {
        let schema = Schema([Food.self, FoodAttribute.self, Favorite.self])
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: config)
        SampleData.createSampleData(into: container.mainContext)
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

fileprivate extension SampleData {
    static func createSampleData(into modelContext: ModelContext) {
        Task { @MainActor in
            preparedDataForPreview.forEach {
                modelContext.insert($0)
            }
            
            preparedDataForPreview[0..<20]
                .forEach { food in
                    modelContext.insert(Favorite(id: food.id, food: food, createdAt: Date()))
                }
            
            try? modelContext.save()
            
            print("✅ 프리뷰용 데이터가 준비되었습니다.")
        }
    }
    
    static let preparedDataForPreview: [Food] = [
        .init(
            id: UUID(uuidString: "98d8f7b2-12ca-49c3-a0ef-000000000000")!,
            title: "훈제 메추리알",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "98d8f7b2-12ca-49c3-a0ef-000000000000")!,
                isPortable: true,
                isCookable: false,
                mainIngredient: .beanTofuEgg
            )
        ),
        .init(
            id: UUID(uuidString: "5ba93f1c-5821-45d7-b269-000000000000")!,
            title: "에그마요 샌드위치",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "5ba93f1c-5821-45d7-b269-000000000000")!,
                isPortable: true,
                isCookable: false,
                mainIngredient: .beanTofuEgg
            )
        ),
        .init(
            id: UUID(uuidString: "3b390561-9bb3-4df9-9f5a-000000000000")!,
            title: "치즈 에그롤",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "3b390561-9bb3-4df9-9f5a-000000000000")!,
                isPortable: true,
                isCookable: false,
                mainIngredient: .beanTofuEgg
            )
        ),
        .init(
            id: UUID(uuidString: "0a447b05-c483-4012-a8be-000000000000")!,
            title: "소고기죽",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "0a447b05-c483-4012-a8be-000000000000")!,
                isPortable: true,
                isCookable: true,
                mainIngredient: .beefPork
            )
        ),
        .init(
            id: UUID(uuidString: "8a9bf6be-2dfc-4498-bd54-000000000000")!,
            title: "닭죽",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "8a9bf6be-2dfc-4498-bd54-000000000000")!,
                isPortable: true,
                isCookable: true,
                mainIngredient: .chickenAndDuck
            )
        ),
        .init(
            id: UUID(uuidString: "fd9d42be-8e4d-43e8-b1c0-000000000000")!,
            title: "닭가슴살 샐러드",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "fd9d42be-8e4d-43e8-b1c0-000000000000")!,
                isPortable: true,
                isCookable: true,
                mainIngredient: .chickenAndDuck
            )
        ),
        .init(
            id: UUID(uuidString: "a2aeceaa-4b89-4176-a513-000000000000")!,
            title: "날치알 주먹밥",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "a2aeceaa-4b89-4176-a513-000000000000")!,
                isPortable: true,
                isCookable: true,
                mainIngredient: .fish
            )
        ),
        .init(
            id: UUID(uuidString: "b9fbc325-de04-48a7-805b-000000000000")!,
            title: "참치마요 주먹밥",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "b9fbc325-de04-48a7-805b-000000000000")!,
                isPortable: true,
                isCookable: true,
                mainIngredient: .fish
            )
        ),
        .init(
            id: UUID(uuidString: "1e37ebf8-1a08-4224-a9ee-000000000000")!,
            title: "맛살전",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "1e37ebf8-1a08-4224-a9ee-000000000000")!,
                isPortable: true,
                isCookable: true,
                mainIngredient: .fish
            )
        ),
        .init(
            id: UUID(uuidString: "a8481881-4d83-41ef-bcda-000000000000")!,
            title: "닭강정",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "a8481881-4d83-41ef-bcda-000000000000")!,
                isPortable: true,
                isCookable: false,
                mainIngredient: .chickenAndDuck
            )
        ),
        .init(
            id: UUID(uuidString: "a5a77c1d-8571-4eef-a4d4-000000000000")!,
            title: "불고기 도시락",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "a5a77c1d-8571-4eef-a4d4-000000000000")!,
                isPortable: true,
                isCookable: false,
                mainIngredient: .beefPork
            )
        ),
        .init(
            id: UUID(uuidString: "34c3009f-625b-4eca-b1b7-000000000000")!,
            title: "닭가슴살 샐러드",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "34c3009f-625b-4eca-b1b7-000000000000")!,
                isPortable: true,
                isCookable: false,
                mainIngredient: .chickenAndDuck
            )
        ),
        .init(
            id: UUID(uuidString: "63b7fbd6-cda6-4ae2-b342-000000000000")!,
            title: "임연수구이(렌지에 돌려먹는)",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "63b7fbd6-cda6-4ae2-b342-000000000000")!,
                isPortable: true,
                isCookable: false,
                mainIngredient: .fish
            )
        ),
        .init(
            id: UUID(uuidString: "c2fcc4cd-b21a-48e6-b8d0-000000000000")!,
            title: "새우볶음밥",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "c2fcc4cd-b21a-48e6-b8d0-000000000000")!,
                isPortable: true,
                isCookable: false,
                mainIngredient: .fish
            )
        ),
        .init(
            id: UUID(uuidString: "59a40758-6946-4d45-bbf8-000000000000")!,
            title: "초밥",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "59a40758-6946-4d45-bbf8-000000000000")!,
                isPortable: true,
                isCookable: false,
                mainIngredient: .fish
            )
        ),
        .init(
            id: UUID(uuidString: "8e7d7655-df69-45c9-a408-000000000000")!,
            title: "마파두부덮밥(컵밥)",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "8e7d7655-df69-45c9-a408-000000000000")!,
                isPortable: true,
                isCookable: false,
                mainIngredient: .beanTofuEgg
            )
        ),
        .init(
            id: UUID(uuidString: "39bc2716-6017-4274-815f-000000000000")!,
            title: "두부텐더",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "39bc2716-6017-4274-815f-000000000000")!,
                isPortable: true,
                isCookable: false,
                mainIngredient: .beanTofuEgg
            )
        ),
        .init(
            id: UUID(uuidString: "2a0b6e70-e5b7-4e41-8c22-000000000000")!,
            title: "두부순대...",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "2a0b6e70-e5b7-4e41-8c22-000000000000")!,
                isPortable: true,
                isCookable: false,
                mainIngredient: .beanTofuEgg
            )
        ),
        .init(
            id: UUID(uuidString: "f039176d-8d2b-4883-aea5-000000000000")!,
            title: "두부샐러드",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "f039176d-8d2b-4883-aea5-000000000000")!,
                isPortable: true,
                isCookable: true,
                mainIngredient: .beanTofuEgg
            )
        ),
        .init(
            id: UUID(uuidString: "b0767ce2-1e64-42b2-969a-000000000000")!,
            title: "두부덮밥",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "b0767ce2-1e64-42b2-969a-000000000000")!,
                isPortable: true,
                isCookable: true,
                mainIngredient: .beanTofuEgg
            )
        ),
        .init(
            id: UUID(uuidString: "ae24fbeb-9a32-4277-9849-000000000000")!,
            title: "두부김밥",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "ae24fbeb-9a32-4277-9849-000000000000")!,
                isPortable: true,
                isCookable: true,
                mainIngredient: .beanTofuEgg
            )
        ),
        .init(
            id: UUID(uuidString: "272b4f03-6811-4a7b-929c-000000000000")!,
            title: "계란 샐러드",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "272b4f03-6811-4a7b-929c-000000000000")!,
                isPortable: true,
                isCookable: true,
                mainIngredient: .beanTofuEgg
            )
        ),
        .init(
            id: UUID(uuidString: "b576f90b-ac50-48ba-8355-000000000000")!,
            title: "에그마요 주먹밥",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "b576f90b-ac50-48ba-8355-000000000000")!,
                isPortable: true,
                isCookable: true,
                mainIngredient: .beanTofuEgg
            )
        ),
        .init(
            id: UUID(uuidString: "d98d1ee0-e2fd-41c7-a388-000000000000")!,
            title: "계란 카레 주먹밥",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "d98d1ee0-e2fd-41c7-a388-000000000000")!,
                isPortable: true,
                isCookable: true,
                mainIngredient: .beanTofuEgg
            )
        ),
        .init(
            id: UUID(uuidString: "724ec180-7649-41e0-b822-000000000000")!,
            title: "소고기 육전",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "724ec180-7649-41e0-b822-000000000000")!,
                isPortable: false,
                isCookable: true,
                mainIngredient: .beefPork
            )
        ),
        .init(
            id: UUID(uuidString: "be5f4e8f-c044-4bec-a767-000000000000")!,
            title: "소고기 덮밥",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "be5f4e8f-c044-4bec-a767-000000000000")!,
                isPortable: false,
                isCookable: true,
                mainIngredient: .beefPork
            )
        ),
        .init(
            id: UUID(uuidString: "b81c64f6-7fd2-4b22-8fe3-000000000000")!,
            title: "수육",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "b81c64f6-7fd2-4b22-8fe3-000000000000")!,
                isPortable: false,
                isCookable: true,
                mainIngredient: .beefPork
            )
        ),
        .init(
            id: UUID(uuidString: "6899c8be-2632-48ea-a8bb-000000000000")!,
            title: "고등어 솥밥",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "6899c8be-2632-48ea-a8bb-000000000000")!,
                isPortable: false,
                isCookable: true,
                mainIngredient: .fish
            )
        ),
        .init(
            id: UUID(uuidString: "d4551f7b-a802-4a1d-a7b8-000000000000")!,
            title: "연어국수",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "d4551f7b-a802-4a1d-a7b8-000000000000")!,
                isPortable: false,
                isCookable: true,
                mainIngredient: .fish
            )
        ),
        .init(
            id: UUID(uuidString: "4b4fcf84-52d1-49e4-a0f6-000000000000")!,
            title: "새우완자전골",
            uniquePoint: "유니크 포인트 테스트",
            attribute: .init(
                id: UUID(uuidString: "4b4fcf84-52d1-49e4-a0f6-000000000000")!,
                isPortable: false,
                isCookable: true,
                mainIngredient: .fish
            )
        )
    ]
}

@available(iOS 18.0, *)
extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var sampleData: Self = .modifier(SampleData())
}
