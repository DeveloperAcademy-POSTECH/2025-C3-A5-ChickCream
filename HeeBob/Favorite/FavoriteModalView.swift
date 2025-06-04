//
//  FavoriteModalView.swift
//  HeeBob
//
//  Created by 산들 on 6/3/25.
//
// TODO: Hifi에 맞게 모달 뷰 수정해야 함.
import SwiftUI

struct FilterButton {
    let title: String
    let value: Bool?
    let action: (Bool?) -> Void
}

struct ToggleInfo {
    var isOn: Binding<Bool>
    let label: String
    let ingredient: FoodIngredient
}

struct FavoriteModalView: View {
    @ObservedObject var favoriteViewModel = FavoriteViewModel()
    
    @State private var isForkBeefToggle: Bool = false
    @State private var isChickenDuckMeatToggle: Bool = false
    @State private var isFishToggle: Bool = false
    @State private var isTofuEggToggle: Bool = false
    
    func userSelectedMainIngredientUpdated() {
        let toggles = [
            (isForkBeefToggle, FoodIngredient.beefPork),
            (isChickenDuckMeatToggle, FoodIngredient.chickenAndDuck),
            (isFishToggle, FoodIngredient.fish),
            (isTofuEggToggle, FoodIngredient.beanTofuEgg)
        ]
        
        favoriteViewModel.mainIngredientsUserSelected = toggles
            .filter { $0.0 }
            .map { $0.1 }
        
        favoriteViewModel.loadFavoritesByUserSelectedOption()
    }
    
    var body: some View {
        
        if favoriteViewModel.showingfavoriteSortType == .portable {
            FilterSectionView(
                title: "휴대성",
                buttons: [
                    FilterButton(title: "모두 보기", value: nil, action: favoriteViewModel.portableSortTypeSelected),
                    FilterButton(title: "챙겨 나가기 좋아요", value: true, action: favoriteViewModel.portableSortTypeSelected),
                    FilterButton(title: "자리에서 먹기 좋아요", value: false, action: favoriteViewModel.portableSortTypeSelected)
                ]
            )
            .presentationDetents([.fraction(0.5)])
        }
        // 조리 유형 섹션
        else if favoriteViewModel.showingfavoriteSortType == .cookable {
            FilterSectionView(
                title: "식사 준비",
                buttons: [
                    FilterButton(title: "모두 보기", value: nil, action: favoriteViewModel.cookableSortTypeSelected),
                    FilterButton(title: "직접 준비할래요", value: true, action: favoriteViewModel.cookableSortTypeSelected),
                    FilterButton(title: "사서 먹을래요", value: false, action: favoriteViewModel.cookableSortTypeSelected)
                ]
            )
            .presentationDetents([.fraction(0.5)])
        }
        else if favoriteViewModel.showingfavoriteSortType == .mainIngredient {
            VStack {
                Text("주재료")
                Divider()
                
                ForEach([
                    ToggleInfo(isOn: $isForkBeefToggle, label: "소고기 돼지고기", ingredient: .beefPork),
                    ToggleInfo(isOn: $isChickenDuckMeatToggle, label: "닭고기 오리고기", ingredient: .chickenAndDuck),
                    ToggleInfo(isOn: $isFishToggle, label: "물고기 해산물", ingredient: .fish),
                    ToggleInfo(isOn: $isTofuEggToggle, label: "콩 두부 달걀", ingredient: .beanTofuEgg)
                ], id: \.ingredient) { toggle in
                    Toggle(isOn: toggle.isOn) {
                        Text(toggle.label)
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .padding()
                    .onChange(of: toggle.isOn.wrappedValue) {
                        userSelectedMainIngredientUpdated()
                    }
                }
                FavoriteMainIngredientModalBtn()
            }
            .presentationDetents([.fraction(0.5)])
        }
    }
}



























//            if favoriteViewModel.showingfavoriteSortType == .portable {
//                VStack(alignment: .leading) {
//                    Text("휴대성")
//                        .padding()
//                    Divider()
//                    //TODO: foreach써서 버튼 반복 돌리기... favorite받아온거 이용해서
//                    Button {
//                        print("모두 보기")
//                        favoriteViewModel.portableSortTypeSelected(for: nil)
//                    } label: {
//                        Text("모두 보기")
//                            .padding()
//                    }
//                    Button {
//                        favoriteViewModel.portableSortTypeSelected(for: true)
//                    } label: {
//                        Text("챙겨 나가기 좋아요")
//                    }
//                    Button {
//                        favoriteViewModel.portableSortTypeSelected(for: false)
//                    } label: {
//                        Text("자리에서 먹기 좋아요")
//                    }
//                }
//                .presentationDetents([.fraction(0.5)])
//            } else if favoriteViewModel.showingfavoriteSortType == .cookable {
//                VStack {
//                    Text("식사 준비")
//                    Divider()
//                    Button {
//                        print("모두 보기")
//                        favoriteViewModel.cookableSortTypeSelected(for: nil)
//                    } label: {
//                        Text("모두 보기")
//                            .padding()
//                    }
//                    Button {
//                        favoriteViewModel.cookableSortTypeSelected(for: true)
//                    } label: {
//                        Text("직접 준비할래요")
//                    }
//                    Button {
//                        favoriteViewModel.cookableSortTypeSelected(for: false)
//                    } label: {
//                        Text("사서 먹을래요")
//                    }
//                }
//                .presentationDetents([.fraction(0.5)])
//            } else if favoriteViewModel.showingfavoriteSortType == .mainIngredient {
//                VStack {
//                Text("주재료")
//                Divider()
//
//                Toggle(isOn: $isForkBeefToggle) {
//                    Text("소고기 돼지고기")
//                }
//                .toggleStyle(CheckboxToggleStyle()) // 체크박스 스타일 적용
//                .padding()
//                .onChange(of: isForkBeefToggle) {
//                    userSelectedMainIngredientUpdated()
//                }
//
//                Toggle(isOn: $isChickenDuckMeatToggle) {
//                    Text("닭고기 오리고기")
//                }
//                .toggleStyle(CheckboxToggleStyle()) // 체크박스 스타일 적용
//                .padding()
//                .onChange(of: isChickenDuckMeatToggle) {
//                    userSelectedMainIngredientUpdated()
//                }
//
//                Toggle(isOn: $isFishToggle) {
//                    Text("물고기 해산물")
//                }
//                .toggleStyle(CheckboxToggleStyle()) // 체크박스 스타일 적용
//                .padding()
//                .onChange(of: isFishToggle) {
//                    userSelectedMainIngredientUpdated()
//                }
//
//                Toggle(isOn: $isTofuEggToggle) {
//                    Text("콩 두부 달걀")
//                }
//                .toggleStyle(CheckboxToggleStyle()) // 체크박스 스타일 적용
//                .padding()
//                .onChange(of: isTofuEggToggle) {
//                    userSelectedMainIngredientUpdated()
//                }
//               }
//                .presentationDetents([.fraction(0.5)])
//
//            }


//extension FavoriteModalView {
//    func userSelectedMainIngredientUpdated() {
//        favoriteViewModel.mainIngredientsUserSelected = [
//            isForkBeefToggle ? .meat : nil,
//            isChickenDuckMeatToggle ? .egg : nil,
//            isFishToggle ? .fish : nil,
//            isTofuEggToggle ? .tofu : nil,
//        ].compactMap { $0 }
//
//        print(favoriteViewModel.mainIngredientsUserSelected)
//
//        favoriteViewModel.loadFavoritesByUserSelectedOption()
//    }
//}

//#Preview {
//    FavoriteModalView()
//}
