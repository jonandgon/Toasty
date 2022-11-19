//
//  ToastBannerModifier.swift
//  Toasty
//
//  Created by Sam Spencer on 11/18/22.
//  Copyright © 2022 nenos, llc. All rights reserved.
//

import SwiftUI

struct ToastBannerModifier: View {
    
    let alert: ToastBanner
    @Binding var isPresenting: Bool
    @Binding var workItem: DispatchWorkItem?
    let tapToDismiss: Bool
    var onTap: (() -> ())?
    var completion: (() -> ())?
    
    internal init(
        _ alert: ToastBanner,
        isPresenting: Binding<Bool>,
        workItem: Binding<DispatchWorkItem?> = .constant(nil),
        tapToDismiss: Bool = true,
        onTap: (() -> ())? = nil,
        completion: (() -> ())? = nil
    ) {
        self.alert = alert
        self._isPresenting = isPresenting
        self._workItem = workItem
        self.tapToDismiss = tapToDismiss
        self.onTap = onTap
        self.completion = completion
    }
    
    var body: some View {
        alert
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
                alert.displayMode == .banner(.slide)
                ? AnyTransition.slide.combined(with: .opacity)
                : AnyTransition.move(edge: .bottom)
            )
    }
    
}
