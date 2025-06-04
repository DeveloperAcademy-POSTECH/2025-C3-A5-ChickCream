//
//  SearchViewPlaceHolder.swift
//  HeeBob
//
//  Created by BoMin Lee on 6/4/25.
//

import SwiftUI

struct SearchViewPlaceHolder: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        VStack {
            Text("SearchView")
                .font(.hbTitle)
            Button {
                router.push(.search)
            } label: {
                Text("검색하러 가라")
            }
        }
        .HBNavigationBar(centerView: { EmptyView() })
    }
}
