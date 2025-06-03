//
//  HomeView.swift
//  HeeBob
//
//  Created by 임영택 on 6/3/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("희밥")
                    .font(.hbTitle)
                
                Spacer()
            }
            
            Text("오직 당신만을 위한\n메뉴로 골라드려요")
                .multilineTextAlignment(.leading)
                .font(.suite(type: .extraBold, size: 36))
            
            Spacer()
            
            HomeButton(title: "메뉴 추천받기") {
                print("메뉴 추천")
            }

            HomeButton(title: "찜한 메뉴 보러가기") {
                print("찜한 메뉴")
            }
        }
        .frame(maxWidth: .infinity)
        .padding(24)
    }
}

struct HomeButton: View {
    let title: String
    let didTap: () -> Void
    
    var body: some View {
        Button {
            didTap()
        } label: {
            ZStack {
                Capsule()
                    .fill(Color.hbPrimary)
                
                Text(title)
                    .foregroundStyle(Color.hbWhite)
                    .font(.hbTitle)
            }
        }
        .frame(height: 90)
    }
}

#Preview {
    HomeView()
}
