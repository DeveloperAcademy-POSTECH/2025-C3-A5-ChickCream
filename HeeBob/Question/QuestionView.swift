//
//  QuestionView.swift
//  HeeBob
//
//  Created by 임영택 on 6/1/25.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var router: NavigationRouter
    
    @StateObject var viewModel = QuestionViewModel()
    
    let buttonsSpacing: CGFloat = 16
    let halfButtonsBottomPadding: CGFloat = 179
    let quarterButtonsBottomPadding: CGFloat = 128
    
    var body: some View {
        VStack(spacing: 0) {
            QuestionIndicatorView(lastPage: viewModel.questions.count, currentPage: viewModel.selectedIndex + 1)
                .padding(.vertical, 12)
            
            Spacer()
            
            QuestionTitleView(viewModel.selectedQuestion.title)
                .padding(.top, viewModel.selectedQuestion.titleTopPadding ?? 85)
                .padding(.bottom, 16)
            
            if let subTitle = viewModel.selectedQuestion.subTitle {
                QuestionSubTitleView(subTitle)
            }
            
            Spacer()
            
            if viewModel.selectedQuestion.options.count == 2 {
                HStack(spacing: buttonsSpacing) {
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
                .padding(.bottom, halfButtonsBottomPadding)
            } else if viewModel.selectedQuestion.options.count == 4 {
                VStack(spacing: buttonsSpacing) {
                    HStack(spacing: buttonsSpacing) {
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
                    
                    HStack(spacing: buttonsSpacing) {
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
                .padding(.bottom, quarterButtonsBottomPadding)
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
                    if viewModel.selectedIndex == viewModel.questions.count - 1,
                       let userAnswer = viewModel.finalAnswer {
                        print(userAnswer)
                        
                        router.push(.result(userAnswer: userAnswer))
                    } else {
                        viewModel.showNextQuestion()
                    }
                }
            }
        }
        .hbBackground()
        .HBNavigationBar(centerView: { EmptyView() })
        .HBNavigationBarBackButtonHidden(viewModel.selectedIndex != 0)
    }
}

#Preview {
    QuestionView()
}
