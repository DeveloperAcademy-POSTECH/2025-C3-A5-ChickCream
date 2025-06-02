//
//  QuestionView.swift
//  HeeBob
//
//  Created by 임영택 on 6/1/25.
//

import SwiftUI

struct QuestionView: View {
    @StateObject var viewModel = QuestionViewModel()
    
    var body: some View {
        VStack {
            /// Navigation Bar
//            HStack {
//                Image(systemName: "chevron.left")
//                Spacer()
//            }
//                .padding(.leading, 16)
//                .background(.clear)
//                .frame(height: 64)
            
            QuestionIndicatorView(lastPage: viewModel.questions.count, currentPage: viewModel.selectedIndex + 1)
            
            Spacer()
            
            QuestionTitleView(viewModel.selectedQuestion.title)
            
            Spacer()
            
            if viewModel.selectedQuestion.options.count == 2 {
                HStack(spacing: 16) {
                    ForEach(viewModel.selectedQuestion.options.indices, id: \.self) { index in
                        QuestionOptionButton(title: viewModel.selectedQuestion.options[index], type: .half, isDisabled: viewModel.selectedQuestion.selectedOptionIndex != index) {
                            viewModel.selectOption(at: index)
                        }
                    }
                }
                .padding(.bottom, 204)
            } else if viewModel.selectedQuestion.options.count == 4 {
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.selectedQuestion.options.indices[0..<2], id: \.self) { index in
                            QuestionOptionButton(title: viewModel.selectedQuestion.options[index], type: .quarter, isDisabled: viewModel.selectedQuestion.selectedOptionIndex != index) {
                                viewModel.selectOption(at: index)
                            }
                        }
                    }
                    
                    HStack(spacing: 16) {
                        ForEach(viewModel.selectedQuestion.options.indices[2..<4], id: \.self) { index in
                            QuestionOptionButton(title: viewModel.selectedQuestion.options[index], type: .quarter, isDisabled: viewModel.selectedQuestion.selectedOptionIndex != index) {
                                viewModel.selectOption(at: index)
                            }
                        }
                    }
                }
                .padding(.bottom, 128)
            } else {
                Text("렌더링할 수 없습니다")
            }
            
            HStack {
                HBButton(configuration: .init(title: "이전", imageName: "chevron.left", imageType: .system, imagePosition: .left, foregroundColor: .hbPrimary, backgroundColor: .hbPrimaryLighten, disabled: viewModel.selectedIndex == 0)) {
                    viewModel.previousButtonTapped()
                }
                
                HBButton(configuration: .init(title: viewModel.selectedIndex == viewModel.questions.count - 1 ? "결과 보기" : "다음", imageName: "chevron.right", imageType: .system, imagePosition: .right, disabled: viewModel.selectedQuestion.selectedOptionIndex == nil)) {
                    viewModel.nextButtonTapped()
                }
            }
        }
    }
}

struct QuestionTitleView: View {
    let content: String
    
    init(_ content: String) {
        self.content = content
    }
    
    var body: some View {
        Text(content)
            .font(.hbTitle)
            .foregroundStyle(Color.hbTextPrimary)
            .multilineTextAlignment(.center)
    }
}

struct QuestionOptionButton: View {
    let title: String
    let type: QuestionOptionButtonType
    let isDisabled: Bool
    let didTap: () -> Void
    
    var body: some View {
        Button {
            didTap()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(isDisabled ? Color.clear : Color.hbPrimaryLighten)
                    .stroke(isDisabled ? Color.hbDisabled : Color.hbPrimary, style: .init(lineWidth: 3))
                    .frame(width: 173, height: type == .half ? 160 : 144 )
                
                Text(title)
                    .font(.hbSubtitle)
                    .foregroundStyle(isDisabled ? Color.hbDisabled : Color.hbPrimary)
            }
        }

    }
    
    enum QuestionOptionButtonType {
        case half
        case quarter
    }
}

#Preview {
    QuestionView()
}
