//
//  TestView.swift
//  HeeBob
//
//  Created by 임영택 on 5/31/25.
//

import SwiftUI
import SwiftData

/// 모든 Food 엔티티를 조회하는 임시 뷰
/// 홈 뷰 구현 후에 제거한다
struct TestView: View {
    @Query(sort: \Food.title, order: .forward) var foods: [Food]
    
    var body: some View {
        VStack {
            List {
                ForEach(foods) { food in
                    Text(food.title)
                }
            }
        }
    }
}

#Preview {
    TestView()
}
