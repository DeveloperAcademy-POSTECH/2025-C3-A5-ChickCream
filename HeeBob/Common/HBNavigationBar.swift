//
//  HBNavigationBar.swift
//  HeeBob
//
//  Created by BoMin Lee on 6/2/25.
//

import SwiftUI
import UIKit
import OSLog

struct HBNavigationBarModifier<L, C, R>: ViewModifier where L: View, C: View, R: View {
    @Environment(\.hbNavigationBarBackButtonHidden) private var hideBackButton
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var router: NavigationRouter
    
    let leftView: (() -> L)?
    let centerView: (() -> C)?
    let rightView: (() -> R)?
    
    let logger = Logger.category("HBNavigationBarModifier")
    
    init(
        leftView: (() -> L)? = nil,
        centerView: (() -> C)? = nil,
        rightView: (() -> R)? = nil) {
            self.leftView = leftView
            self.centerView = centerView
            self.rightView = rightView
        }
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    if !hideBackButton {
                        Button(action: {
                            dismiss()
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
            .background(Color.hbBackground)
            .ignoresSafeArea(.all, edges: .horizontal)
            .ignoresSafeArea(.all, edges: .bottom)
            content
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: hideBackButton) { _, hideBackButton in
            logger.debug("👁️ hideBackButton changed => UINavigationController.isGestureDisabled \(hideBackButton)")
            UINavigationController.isGestureDisabled = hideBackButton
        }
        .onChange(of: router.path) { _, path in
            logger.debug("👁️ path changed => UINavigationController.isGestureDisabled false")
            UINavigationController.isGestureDisabled = false // init for every foreground views
        }
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

extension UINavigationController: UIGestureRecognizerDelegate {
    fileprivate static var isGestureDisabled: Bool = false
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1 && !UINavigationController.isGestureDisabled
    }
}
