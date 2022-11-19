//
//  ToastAlertModifier.swift
//  
//
//  Created by Sam Spencer on 11/18/22.
//  Copyright © 2022 nenos, llc. All rights reserved.
//

import Foundation
import SwiftUI

struct ToastAlertModifier: View {
    
    let alert: ToastAlert
    @Binding var isPresenting: Bool
    @Binding var workItem: DispatchWorkItem?
    let tapToDismiss: Bool
    var onTap: (() -> ())?
    var completion: (() -> ())?
    
    internal init(
        _ alert: ToastAlert,
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
                .scale(scale: 0.8)
                .combined(with: .opacity)
            )
    }
    
}
