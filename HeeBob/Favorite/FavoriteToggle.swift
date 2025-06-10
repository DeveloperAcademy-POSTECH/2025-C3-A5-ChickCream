//
//  FavoriteToggle.swift
//  HeeBob
//
//  Created by 산들 on 6/9/25.
//

import SwiftUI

struct FavoriteMainIngredientToggleInfo {
    var isOn: Binding<Bool>
    let label: String
    let ingredient: FoodIngredient
}

struct FavoriteToggle: View {
    @ObservedObject var favoriteViewModel: FavoriteViewModel
    
    var body: some View {
        Text("주재료")
            .font(.hbSubtitle)
            .foregroundStyle(Color.hbTextPrimary)
            .padding(.bottom, 16)
            .padding(.top, 0)
            .padding(.leading, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
        Divider()
            .padding(.bottom, 16)
            .padding(.top, 0)
        // TODO: 디자인 HIFI에 맞게 변경 예정
  
            ForEach([
                FavoriteMainIngredientToggleInfo(isOn: $favoriteViewModel.isForkBeefToggle, label: "소고기 돼지고기", ingredient: .beefPork),
                FavoriteMainIngredientToggleInfo(isOn: $favoriteViewModel.isChickenDuckMeatToggle, label: "닭고기 오리고기", ingredient: .chickenAndDuck),
                FavoriteMainIngredientToggleInfo(isOn: $favoriteViewModel.isFishToggle, label: "물고기 해산물", ingredient: .fish),
                FavoriteMainIngredientToggleInfo(isOn: $favoriteViewModel.isTofuEggToggle, label: "콩 두부 달걀", ingredient: .beanTofuEgg)
            ], id: \.ingredient) { toggle in
                Toggle(isOn: toggle.isOn) {
                    Text(toggle.label)
                        .font(.hbBody2)
                        .foregroundStyle(Color.hbTextPrimary)
                }
                .toggleStyle(CheckboxToggleStyle())
                .padding(.bottom, 16)
                .padding(.top, 0)
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onChange(of: toggle.isOn.wrappedValue) {
                    userSelectedMainIngredientUpdated()
                }
            }
        
    }
    
    func userSelectedMainIngredientUpdated() {
        let toggles = [
            (favoriteViewModel.isForkBeefToggle, FoodIngredient.beefPork),
            (favoriteViewModel.isChickenDuckMeatToggle, FoodIngredient.chickenAndDuck),
            (favoriteViewModel.isFishToggle, FoodIngredient.fish),
            (favoriteViewModel.isTofuEggToggle, FoodIngredient.beanTofuEgg)
        ]
        
        favoriteViewModel.mainIngredientsUserSelected = toggles
            .filter { $0.0 }
            .map { $0.1 }
        
        favoriteViewModel.loadFavoritesByUserSelectedOption()
    }
}
