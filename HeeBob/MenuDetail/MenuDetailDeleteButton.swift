//
//  MenuDetailDeleteButton.swift
//  HeeBob
//
//  Created by 산들 on 6/4/25.
//

import SwiftUI

struct MenuDetailDeleteButton: View {
    var food: Food
    @Environment(\.modelContext) private var modelContext
    @State private var showFavoriteDeleteAlert = false
    
    var body: some View {
        Button("찜에서 삭제하기") {
            showFavoriteDeleteAlert = true
        }
        .alert("알림 제목", isPresented: $showFavoriteDeleteAlert) {
            Button("삭제", role: .destructive) {
                modelContext.delete(food)
            }
            Button("취소", role: .cancel) { }
        } message: {
            Text("정말 삭제 하시겠습니까?")
        }
        .padding(.top, 40)
        .font(.hbSubtitle)
        .foregroundStyle(Color.hbDisabled)
    }
}

