//
//  MenuDetailDeleteButton.swift
//  HeeBob
//
//  Created by 산들 on 6/4/25.
//

import SwiftUI

struct MenuDetailDeleteButton: View {
    var favorite: Favorite
    @Environment(\.modelContext) private var modelContext
    @State private var showFavoriteDeleteAlert = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button("찜에서 삭제하기") {
            showFavoriteDeleteAlert = true
        }
        .alert("정말 삭제 하시겠습니까?", isPresented: $showFavoriteDeleteAlert) {
            Button("삭제", role: .destructive) {
                modelContext.delete(favorite)
                
                do {
                    try modelContext.save()
                    dismiss()
                } catch {
                    print("error deleting favorite: \(error)")
                }
            }
            Button("취소", role: .cancel) { }
        }
        .padding(.top, 40)
        .font(.hbSubtitle)
        .foregroundStyle(Color.hbDisabled)
    }
}

