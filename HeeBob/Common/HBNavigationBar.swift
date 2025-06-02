//
//  HBNavigationBar.swift
//  HeeBob
//
//  Created by BoMin Lee on 6/2/25.
//

import SwiftUI

struct HBNavigationBarModifier<L, C, R>: ViewModifier where L: View, C: View, R: View {
    @Environment(\.hbNavigationBarBackButtonHidden) private var hideBackButton
    
    let leftView: (() -> L)?
    let centerView: (() -> C)?
    let rightView: (() -> R)?
    
    init(
        leftView: (() -> L)? = nil,
        centerView: (() -> C)? = nil,
        rightView: (() -> R)? = nil) {
            self.leftView = leftView
            self.centerView = centerView
            self.rightView = rightView
        }
    
    func body(content: Content) -> some View {
        VStack {
            ZStack {
                HStack {
                    if !hideBackButton {
                        Button(action: {
                            print("Back Button Pressed")
                        }) {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.hbTextPrimary)
                                .frame(width: 13)
                        }
                    } else {
                        self.leftView?()
                    }
                    Spacer()
                    self.rightView?()
                }
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                
                HStack {
                    Spacer()
                    self.centerView?()
                    Spacer()
                }
            }
            .background(Color.hbBackground) // FIXME: hbWhite로 수정
            .ignoresSafeArea(.all, edges: .horizontal)
            .ignoresSafeArea(.all, edges: .bottom)
            content
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension View {
    func HBNavigationBar<L, C, R> (
        leftView: @escaping (() -> L),
        centerView: @escaping (() -> C),
        rightView: @escaping (() -> R)
    ) -> some View where L: View, C: View, R: View {
        modifier(
            HBNavigationBarModifier(
                leftView: leftView,
                centerView: centerView,
                rightView: rightView
            )
        )
    }
    
    func HBNavigatonBar<L, C> (
        leftView: @escaping (() -> L),
        centerView: @escaping (() -> C)
    ) -> some View where L: View, C: View {
        modifier(
            HBNavigationBarModifier(
                leftView: leftView,
                centerView: centerView,
                rightView: {
                    EmptyView()
                }
            )
        )
    }
    
    func HBNavigationBar<C> (
        centerView: @escaping (() -> C)
    ) -> some View where C: View {
        modifier(
            HBNavigationBarModifier(
                leftView: {
                    EmptyView()
                }, centerView: centerView,
                rightView: {
                    EmptyView()
                }
            )
        )
    }
    
    func HBNavigationBar<L> (
        leftView: @escaping (() -> L)
    ) -> some View where L: View {
        modifier(
            HBNavigationBarModifier(
                leftView: leftView,
                centerView: {
                    EmptyView()
                }, rightView: {
                    EmptyView()
                })
        )
    }
}

extension View {
    func HBNavigationBarBackButtonHidden(_ hidden: Bool) -> some View {
        environment(\.hbNavigationBarBackButtonHidden, hidden)
    }
}
