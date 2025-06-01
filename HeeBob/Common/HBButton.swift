//
//  HBButton.swift
//  HeeBob
//
//  Created by 임영택 on 6/1/25.
//

import SwiftUI

struct HBButton: View {
    let configuration: HBButton.Configuration
    let didButtonTap: () -> Void
    
    var body: some View {
        Button {
            didButtonTap()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(
                        configuration.disabled
                            ? .hbDisabled
                            : configuration.backgroundColor
                    )
                
                // 이미지가 왼쪽에 있는 경우
                if configuration.imagePosition == .left {
                    HStack(spacing: 0) {
                        if let imageName = configuration.imageName,
                           configuration.imageType == .system {
                            Image(systemName: imageName)
                                .renderingMode(.template)
                                .padding(.leading, 16)
                                .padding(.trailing, 40)
                        }
                        
                        if let imageName = configuration.imageName,
                           configuration.imageType == .asset {
                            Image(imageName)
                                .padding(.trailing, 40)
                        }
                        
                        Text(configuration.title)
                            .font(.hbSubtitle)
                        
                        Spacer()
                    }
                }
                
                // 이미지가 오른쪽에 있는 경우
                if configuration.imagePosition == .right {
                    HStack(spacing: 0) {
                        Spacer()
                        
                        Text(configuration.title)
                            .font(.hbSubtitle)
                        
                        if let imageName = configuration.imageName,
                           configuration.imageType == .system {
                            Image(systemName: imageName)
                                .renderingMode(.template)
                                .padding(.leading, 40)
                                .padding(.trailing, 16)
                        }
                        
                        if let imageName = configuration.imageName,
                           configuration.imageType == .asset {
                            Image(imageName)
                                .padding(.trailing, 40)
                        }
                    }
                }
                
                // 이미지가 없는 경우
                if configuration.imagePosition == nil {
                    Text(configuration.title)
                        .font(.hbSubtitle)
                }
            }
        }
        .foregroundStyle(
            configuration.disabled
                ? .white
                : configuration.foregroundColor
        )
        .disabled(configuration.disabled)
        .frame(width: 173, height: 72)
    }
    
    struct Configuration {
        let title: String
        let imageName: String?
        let imageType: ImageType?
        let imagePosition: ImagePosition?
        let foregroundColor: Color
        let backgroundColor: Color
        let disabled: Bool
        
        init(title: String, imageName: String? = nil, imageType: ImageType? = nil, imagePosition: ImagePosition? = nil, foregroundColor: Color = .white, backgroundColor: Color = .hbPrimary, disabled: Bool = false) {
            self.title = title
            self.imageName = imageName
            self.imageType = imageType
            self.imagePosition = imagePosition
            self.foregroundColor = foregroundColor
            self.backgroundColor = backgroundColor
            self.disabled = disabled
        }
        
        enum ImageType {
            case system
            case asset
        }
        
        enum ImagePosition {
            case left
            case right
        }
    }
}

#Preview {
    HBButton(
        configuration: .init(
            title: "이전",
            imageName: "chevron.left",
            imageType: .system,
            imagePosition: .left,
            foregroundColor: .hbPrimary,
            backgroundColor: .hbPrimaryLighten
        )) {
            print("Button Tapped")
        }
    
    HBButton(
        configuration: .init(
            title: "다음",
            imageName: "chevron.right",
            imageType: .system,
            imagePosition: .right
        )) {
            print("Button Tapped")
        }
    
    HBButton(
        configuration: .init(
            title: "홈"
        )) {
            print("Button Tapped")
        }
    
    HBButton(
        configuration: .init(
            title: "홈",
            disabled: true
        )) {
            print("Button Tapped")
        }
}
