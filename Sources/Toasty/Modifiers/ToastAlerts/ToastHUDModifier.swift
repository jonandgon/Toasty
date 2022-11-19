//
//  ToastHUDModifier.swift
//  Toasty
//
//  Created by Sam Spencer on 11/18/22.
//  Copyright © 2022 nenos, llc. All rights reserved.
//

import SwiftUI

struct ToastHUDModifier: View {
    
    let alert: ToastHUD
    @Binding var isPresenting: Bool
    @Binding var workItem: DispatchWorkItem?
    @Binding var alertRect: CGRect
    let tapToDismiss: Bool
    var onTap: (() -> ())?
    var completion: (() -> ())?
    
    internal init(
        _ alert: ToastHUD,
        isPresenting: Binding<Bool>,
        workItem: Binding<DispatchWorkItem?> = .constant(nil),
        alertRect: Binding<CGRect>,
        tapToDismiss: Bool = true,
        onTap: (() -> ())? = nil,
        completion: (() -> ())? = nil
    ) {
        self.alert = alert
        self._isPresenting = isPresenting
        self._workItem = workItem
        self._alertRect = alertRect
        self.tapToDismiss = tapToDismiss
        self.onTap = onTap
        self.completion = completion
    }
    
    var body: some View {
        alert
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
    
}
