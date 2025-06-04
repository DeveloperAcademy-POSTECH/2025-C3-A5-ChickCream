//
//  FavoriteViewPlaceHolder.swift
//  HeeBob
//
//  Created by BoMin Lee on 6/4/25.
//

import SwiftUI

struct FavoriteViewPlaceHolder: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        VStack {
            Text("FavoriteView")
                .font(.hbSubtitle)
            Button {
                router.push(.search)
            } label: {
                Text("검색하러 가라")
            }
        }
        .HBNavigationBar(centerView: {
            Text("추천 메뉴")
                .font(.hbTitle)
        })
    }
}
