//
//  FavoriteToggle.swift
//  HeeBob
//
//  Created by 산들 on 6/9/25.
//

import SwiftUI

struct ToggleInfo {
    var isOn: Binding<Bool>
    let label: String
    let ingredient: FoodIngredient
}

struct FavoriteToggle: View {
    @ObservedObject var favoriteViewModel = FavoriteViewModel()

    @Binding var isForkBeefToggle: Bool
    @Binding var isChickenDuckMeatToggle: Bool
    @Binding var isFishToggle: Bool
    @Binding var isTofuEggToggle: Bool
    
    var body: some View {
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
    }
    
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
}
