//
//  Route.swift
//  HeeBob
//
//  Created by BoMin Lee on 6/2/25.
//

import SwiftUI


/// 단순 이동뿐만 아니라, 화면에 필요한 데이터를 함께 전달 가능
enum Route: Hashable { // Hashable을 채택해야 NavigationPath에서 활용 가능
    case home
    case question
    case loading // 결과 확인 내부로 뺄지 고민
    case result
    case favorite
}


