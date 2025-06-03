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
            QuestionIndicatorView(lastPage: viewModel.questions.count, currentPage: viewModel.selectedIndex + 1)
            
            Spacer()
            
            QuestionTitleView(viewModel.selectedQuestion.title)
            
            Spacer()
            
            if viewModel.selectedQuestion.options.count == 2 {
                HStack(spacing: 16) {
                    ForEach(viewModel.selectedQuestion.options.indices, id: \.self) { index in
                        QuestionOptionButton(
                            title: viewModel.selectedQuestion.options[index],
                            type: .half,
                            isDisabled: viewModel.selectedQuestion.selectedOptionIndex != index
                        ) {
                            viewModel.selectOption(at: index)
                        }
                    }
                }
                .padding(.bottom, 204)
            } else if viewModel.selectedQuestion.options.count == 4 {
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.selectedQuestion.options.indices[0..<2], id: \.self) { index in
                            QuestionOptionButton(
                                title: viewModel.selectedQuestion.options[index],
                                type: .quarter,
                                isDisabled: viewModel.selectedQuestion.selectedOptionIndex != index
                            ) {
                                viewModel.selectOption(at: index)
                            }
                        }
                    }
                    
                    HStack(spacing: 16) {
                        ForEach(viewModel.selectedQuestion.options.indices[2..<4], id: \.self) { index in
                            QuestionOptionButton(
                                title: viewModel.selectedQuestion.options[index],
                                type: .quarter,
                                isDisabled: viewModel.selectedQuestion.selectedOptionIndex != index
                            ) {
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
                HBButton(
                    configuration: .init(
                        title: "이전",
                        imageName: "chevron.left",
                        imageType: .system,
                        imagePosition: .left,
                        foregroundColor: .hbPrimary,
                        backgroundColor: .hbPrimaryLighten,
                        disabled: viewModel.selectedIndex == 0
                    )
                ) {
                    viewModel.showPreviousQuestion()
                }
                
                HBButton(
                    configuration: .init(
                        title: viewModel.selectedIndex == viewModel.questions.count - 1 ? "결과 보기" : "다음",
                        imageName: "chevron.right",
                        imageType: .system,
                        imagePosition: .right,
                        disabled: viewModel.selectedQuestion.selectedOptionIndex == nil)
                ) {
                    if viewModel.selectedIndex == viewModel.questions.count - 1 {
                        print(viewModel.synthesizedAnswer) // TODO: UserModel을 결과 로딩 뷰로 넘김
                    } else {
                        viewModel.showNextQuestion()
                    }
                }
            }
        }
        .HBNavigationBar(centerView: { EmptyView() })
        .HBNavigationBarBackButtonHidden(viewModel.selectedIndex != 0)
    }
}

#Preview {
    QuestionView()
}
