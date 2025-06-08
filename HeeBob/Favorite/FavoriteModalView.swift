//
//  FavoriteModalView.swift
//  HeeBob
//
//  Created by 산들 on 6/3/25.
//
import SwiftUI

struct FilterButton {
    let title: String
    let value: Bool?
    let action: (Bool?) -> Void
}

// TODO: Hifi에 맞게 주재료 모달 뷰 수정
struct FavoriteModalView: View {
    @ObservedObject var favoriteViewModel = FavoriteViewModel()
    
    @State var isForkBeefToggle: Bool = false
    @State var isChickenDuckMeatToggle: Bool = false
    @State var isFishToggle: Bool = false
    @State var isTofuEggToggle: Bool = false
    
    var body: some View {
        
        if favoriteViewModel.showingfavoriteSortType == .portable {
            FilterSectionView(
                title: "휴대성",
                buttons: [
                    FilterButton(title: "모두 보기", value: nil, action: favoriteViewModel.portableSortTypeSelected),
                    FilterButton(title: "챙겨 나가기 좋아요", value: true, action: favoriteViewModel.portableSortTypeSelected),
                    FilterButton(title: "자리에서 먹기 좋아요", value: false, action: favoriteViewModel.portableSortTypeSelected)
                ],
                selectedValue: $favoriteViewModel.isPortableUserSelected
            )
            .presentationDetents([.fraction(0.35)])
        }
        // 조리 유형 섹션
        else if favoriteViewModel.showingfavoriteSortType == .cookable {
            FilterSectionView(
                title: "식사 준비",
                buttons: [
                    FilterButton(title: "모두 보기", value: nil, action: favoriteViewModel.cookableSortTypeSelected),
                    FilterButton(title: "직접 준비할래요", value: true, action: favoriteViewModel.cookableSortTypeSelected),
                    FilterButton(title: "사서 먹을래요", value: false, action: favoriteViewModel.cookableSortTypeSelected)
                ], selectedValue: $favoriteViewModel.isCookableUserSelected
                
            )
            .presentationDetents([.fraction(0.35)])
        } // FIXME: 토글을 다른 뷰로 빼니까 토글 작동을 안함 ㅋㅋ;
        else if favoriteViewModel.showingfavoriteSortType == .mainIngredient {
            VStack {
                FavoriteToggle(isForkBeefToggle: $isForkBeefToggle, isChickenDuckMeatToggle: $isChickenDuckMeatToggle, isFishToggle: $isFishToggle, isTofuEggToggle: $isTofuEggToggle)
                
                FavoriteMainIngredientModalBtn(isForkBeefToggle: $isForkBeefToggle, isChickenDuckMeatToggle: $isChickenDuckMeatToggle, isFishToggle: $isFishToggle, isTofuEggToggle: $isTofuEggToggle)
            }
            .presentationDetents([.fraction(0.5)])
        }
    }
}
