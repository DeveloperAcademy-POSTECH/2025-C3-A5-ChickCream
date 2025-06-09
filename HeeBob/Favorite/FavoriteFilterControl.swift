//
//  HeeBob
//
//  Created by 산들 on 6/3/25.
//

import SwiftUI

struct FavoriteFilterControl: View {
    @ObservedObject var favoriteViewModel: FavoriteViewModel
    @State var btnColorChange : Bool = false
    
    var body: some View {
        HStack {
            ForEach(FavoriteViewModel.FavoriteSortType.allCases, id: \.self) { sortType in
                FavoriteFilterButton(favoriteViewModel: favoriteViewModel, title: sortType.rawValue, filterType: sortType) {
                    favoriteViewModel.filterSelectButtonTapped(for: sortType)
                }
            }
        }
        .sheet(item: $favoriteViewModel.showingfavoriteSortType) { modalType in
            switch modalType {
            case .portable:
                FavoriteModalView(favoriteViewModel: favoriteViewModel)
            case .cookable:
                FavoriteModalView(favoriteViewModel: favoriteViewModel)
            case .mainIngredient:
                FavoriteModalView(favoriteViewModel: favoriteViewModel)
            }
        }
    }
}
