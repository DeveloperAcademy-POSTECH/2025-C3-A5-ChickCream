//
//  FavoriteModalView.swift
//  HeeBob
//
//  Created by 산들 on 6/3/25.
//

import SwiftUI

struct FavoriteModalView: View {
    @ObservedObject var favoriteViewModel = FavoriteViewModel()
    
    @State private var isForkBeefToggle: Bool = false {
        didSet {
            print("changed")
            userSelectedMainIngredientUpdated()
        }
    }
    @State private var isChickenDuckMeatToggle: Bool = false {
        didSet {
            print("changed")
            userSelectedMainIngredientUpdated()
        }
    }
    @State private var isFishToggle: Bool = false {
        didSet {
            print("changed")
            userSelectedMainIngredientUpdated()
        }
    }
    @State private var isTofuEggToggle: Bool = false
    
    var body: some View {
        Group {
            if favoriteViewModel.showingfavoriteSortType == .portable {
                VStack(alignment: .leading) {
                    Text("휴대성")
                        .padding()
                    Divider()
                    //TODO: foreach써서 버튼 반복 돌리기... favorite받아온거 이용해서
                    
                    Button {
                        print("모두 보기")
                        favoriteViewModel.portableSortTypeSelected(for: nil)
                    } label: {
                        Text("모두 보기")
                            .padding()
                    }
                    Button {
                        favoriteViewModel.portableSortTypeSelected(for: true)
                    } label: {
                        Text("챙겨 나가기 좋아요")
                    }
                    Button {
                        favoriteViewModel.portableSortTypeSelected(for: false)
                    } label: {
                        Text("자리에서 먹기 좋아요")
                    }
                }
                .presentationDetents([.fraction(0.5)])
            } else if favoriteViewModel.showingfavoriteSortType == .cookable {
                Text("식사 준비")
                Divider()
                
                Button {
                    print("모두 보기")
                    favoriteViewModel.cookableSortTypeSelected(for: nil)
                } label: {
                    Text("모두 보기")
                        .padding()
                }
                Button {
                    favoriteViewModel.cookableSortTypeSelected(for: true)
                } label: {
                    Text("직접 준비할래요")
                }
                Button {
                    favoriteViewModel.cookableSortTypeSelected(for: false)
                } label: {
                    Text("사서 먹을래요")
                }
                .presentationDetents([.fraction(0.5)])
            } else if favoriteViewModel.showingfavoriteSortType == .mainIngredient {
                Text("주재료")
                Divider()
                
                Toggle(isOn: $isForkBeefToggle) {
                    Text("소고기 돼지고기")
                }
                .toggleStyle(CheckboxToggleStyle()) // 체크박스 스타일 적용
                .padding()
                //            .onChange(of: isForkBeefToggle) {
                //                if isForkBeefToggle {
                //                    favoriteViewModel.mainIngredientSortTypeSelected(for: isForkBeefToggle)
                //                } else {
                //                    favoriteViewModel.mainIngredientSortTypeSelected(for: nil)
                //                }
                //            }
    //            .onChange(of: isForkBeefToggle) {
    //                userSelectedMainIngredientUpdated()
    //            }
                
                Toggle(isOn: $isChickenDuckMeatToggle) {
                    Text("닭고기 오리고기")
                }
                .toggleStyle(CheckboxToggleStyle()) // 체크박스 스타일 적용
                .padding()
                //            .onChange(of: isChickenDuckMeat) {
                //                if isChickenDuckMeatToggle {
                //                    favoriteViewModel.mainIngredientSortTypeSelected(for: isChickenDuckMeat)
                //                } else {
                //                    favoriteViewModel.mainIngredientSortTypeSelected(for: nil)
                //                }
                //            }
    //            .onChange(of: isChickenDuckMeatToggle) {
    //                userSelectedMainIngredientUpdated()
    //            }
                
                Toggle(isOn: $isFishToggle) {
                    Text("물고기 해산물")
                }
                .toggleStyle(CheckboxToggleStyle()) // 체크박스 스타일 적용
                .padding()
                //            .onChange(of: isFish) {
                //                if isFishToggle {
                //                    favoriteViewModel.mainIngredientSortTypeSelected(for: isFish)
                //                } else {
                //                    favoriteViewModel.mainIngredientSortTypeSelected(for: nil)
                //                }
                //            }
    //            .onChange(of: isFishToggle) {
    //                userSelectedMainIngredientUpdated()
    //            }
                
                Toggle(isOn: $isTofuEggToggle) {
                    Text("콩 두부 달걀 \(isTofuEggToggle)")
                }
                .toggleStyle(CheckboxToggleStyle()) // 체크박스 스타일 적용
                .padding()
                //            .onChange(of: isTofuEgg) {
                //                if isTofuEggToggle {
                //                    favoriteViewModel.mainIngredientSortTypeSelected(for: isTofuEgg)
                //                } else {
                //                    favoriteViewModel.mainIngredientSortTypeSelected(for: nil)
                //                }
                //            }
               
                .presentationDetents([.fraction(0.5)])
                .onChange(of: isTofuEggToggle) {
                    print("asdfasdfasdf")
                    userSelectedMainIngredientUpdated()
                }
            }
        }
//        .onChange(of: isTofuEggToggle) {
//            print("asdfasdfasdf")
//            userSelectedMainIngredientUpdated()
//        }
    }
}

extension FavoriteModalView {
    func userSelectedMainIngredientUpdated() {
        favoriteViewModel.mainIngredientsUserSelected = [
            isForkBeefToggle ? .meat : nil,
            isChickenDuckMeatToggle ? .egg : nil,
            isFishToggle ? .fish : nil,
            isTofuEggToggle ? .tofu : nil,
        ].compactMap { $0 }
        
        print(favoriteViewModel.mainIngredientsUserSelected)
    }
}

//#Preview {
//    FavoriteModalView()
//}
