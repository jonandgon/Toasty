//
//  AlertToastModifier.swift
//  Toasty
//
//  Created by Sam Spencer on 11/7/22.
//  Licensed under the MIT License.
//

import Foundation
import SwiftUI

public struct AlertToastModifier<T: Toast>: ViewModifier {
    
    typealias AlertClosure<T> = () -> T
    
    // MARK: - Properties
    
    /// Presentation `Binding<Bool>`
    ///
    @Binding var isPresenting: Bool
    
    /// Duration time to display the alert.
    ///
    @State var duration: Double = 2
    
    /// Tap to dismiss alert.
    ///
    @State var tapToDismiss: Bool = true
    
    var offsetY: CGFloat = 0
    
    // MARK: Closures
    
    /// Block which is expected to return a ``Toast`` view.
    ///
    var alert: AlertClosure<T>
    
    var onTap: (() -> ())? = nil
    
    /// Completion block called after dismissal.
    ///
    var completion: (() -> ())? = nil
    
    @State private var workItem: DispatchWorkItem?
    
    // MARK: Positioning
    
    @State private var hostRect: CGRect = .zero
    @State private var alertRect: CGRect = .zero
    
    private var screen: CGRect {
        #if os(iOS)
        return UIScreen.main.bounds
        #else
        return NSScreen.main?.frame ?? .zero
        #endif
    }
    
    private var offset: CGFloat {
        return -hostRect.midY + alertRect.height
    }
    
    init(
        isPresenting: Binding<Bool>,
        duration: Double = 2,
        tapToDismiss: Bool = true,
        offsetY: CGFloat = 0,
        alert: @escaping AlertClosure<T>,
        onTap: (() -> ())? = nil,
        completion: (() -> ())? = nil
    ) {
        self._isPresenting = isPresenting
        self.duration = duration
        self.tapToDismiss = tapToDismiss
        self.offsetY = offsetY
        self.alert = alert
        self.onTap = onTap
        self.completion = completion
    }
    
    // MARK: - Entry Point
    
    @ViewBuilder public func body(content: Content) -> some View {
        switch alert().displayMode {
        case .banner:
            content
                .overlay {
                    ZStack {
                        main().offset(y: offsetY)
                    }
                    .animation(Animation.spring(), value: isPresenting)
                }
                .valueChanged(value: isPresenting) { (presented) in
                    if presented {
                        onAppearAction()
                    }
                }
        case .hud:
            content
                .overlay {
                    GeometryReader { geo -> AnyView in
                        let rect = geo.frame(in: .global)
                        
                        if rect.integral != hostRect.integral {
                            DispatchQueue.main.async {
                                self.hostRect = rect
                            }
                        }
                        
                        return AnyView(EmptyView())
                    }
                    .overlay {
                        ZStack {
                            main()
                                .offset(y: offsetY)
                        }
                        .frame(maxWidth: screen.width, maxHeight: screen.height)
                        .offset(y: offset)
                        .animation(Animation.spring(), value: isPresenting)
                    }
                }
                .valueChanged(value: isPresenting) { presented in
                    if presented {
                        onAppearAction()
                    }
                }
        case .alert:
            content
                .overlay {
                    ZStack {
                        main().offset(y: offsetY)
                    }
                    .frame(maxWidth: screen.width, maxHeight: screen.height, alignment: .center)
                    .edgesIgnoringSafeArea(.all)
                    .animation(Animation.spring(), value: isPresenting)
                }
                .valueChanged(value: isPresenting) { presented in
                    if presented {
                        onAppearAction()
                    }
                }
        }
    }
    
    // MARK: - Content
    
    @ViewBuilder public func main() -> some View {
        if isPresenting {
            switch alert().displayMode {
            case .alert: mainAlertContent()
            case .hud: mainHUDContent()
            case .banner: mainBannerContent()
            }
        }
    }
    
    @ViewBuilder private func mainAlertContent() -> some View {
        alert()
            .onTapGesture {
                onTap?()
                if tapToDismiss {
                    withAnimation(.spring()) {
                        self.workItem?.cancel()
                        isPresenting = false
                        self.workItem = nil
                    }
                }
            }
            .onDisappear {
                completion?()
            }
            .transition(
                .scale(scale: 0.8)
                .combined(with: .opacity)
            )
    }
    
    @ViewBuilder private func mainHUDContent() -> some View {
        alert()
            .overlay(
                GeometryReader { geo -> AnyView in
                    let rect = geo.frame(in: .global)
                    if rect.integral != alertRect.integral {
                        DispatchQueue.main.async {
                            self.alertRect = rect
                        }
                    }
                    return AnyView(EmptyView())
                }
            )
            .onTapGesture {
                onTap?()
                if tapToDismiss {
                    withAnimation(.spring()) {
                        self.workItem?.cancel()
                        isPresenting = false
                        self.workItem = nil
                    }
                }
            }
            .onDisappear {
                completion?()
            }
            .transition(
                .move(edge: .top)
                .combined(with: .opacity)
            )
    }
    
    @ViewBuilder private func mainBannerContent() -> some View {
        alert()
            .onTapGesture {
                onTap?()
                if tapToDismiss {
                    withAnimation(.spring()) {
                        self.workItem?.cancel()
                        isPresenting = false
                        self.workItem = nil
                    }
                }
            }
            .onDisappear {
                completion?()
            }
            .transition(
                alert().displayMode == .banner(.slide)
                ? AnyTransition.slide.combined(with: .opacity)
                : AnyTransition.move(edge: .bottom)
            )
    }
    
    
    // MARK: - Actions
    
    private func onAppearAction() {
        guard workItem == nil else {
            return
        }
        
        if alert().type == .loading {
            duration = 0
            tapToDismiss = false
        }
        
        if duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                withAnimation(Animation.spring()) {
                    isPresenting = false
                    workItem = nil
                }
            }
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: task)
        }
    }
    
}
