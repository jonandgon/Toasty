//
//  ToastQueueModifier.swift
//  Toasty
//
//  Created by Sam Spencer on 11/18/22.
//  Licensed under the MIT License.
//

import Foundation
import SwiftUI

public struct ToastQueueModifier: ViewModifier {
    
    // MARK: - Properties
    
    @ObservedObject var toaster: Toaster
    
    /// Presentation `Binding<Bool>`
    ///
    @State var isPresenting: Bool = false
    
    /// Duration time to display the alert.
    ///
    @State var duration: Double = 2
    
    /// Tap to dismiss alert.
    ///
    @State var tapToDismiss: Bool = true
    
    var offsetY: CGFloat = 0
    
    /// The current ``ToastQueueItem`` from the shared ``Toaster``.
    ///
    @State var toastItem: ToastQueueItem?
    
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
    
    public init(_ toasterQueue: Toaster) {
        self.toaster = toasterQueue
        self.toastItem = toasterQueue.current
    }
    
    // MARK: - Entry Point
    
    @ViewBuilder public func body(content: Content) -> some View {
        content
            .onReceive(toaster.$current) { updatedToast in
                if toastItem == nil {
                    // There is no toast item
                    toastItem = updatedToast
                    isPresenting = true
                } else {
                    // There is already a toast item
                    if updatedToast == nil {
                        // The updated toast is nil
                        isPresenting = false
                    } else {
                        isPresenting = false
                        
                        if updatedToast != toastItem {
                            toastItem = updatedToast
                            isPresenting = true
                        }
                    }
                }
            }
            .overlay {
                if toastItem != nil {
                    toastOverlay()
                } else {
                    EmptyView()
                }
            }
            .animation(.spring(), value: toastItem)
    }
    
    @ViewBuilder public func toastOverlay() -> some View {
        switch toastItem!.toast.displayMode {
        case .banner:
            main()
                .animation(Animation.spring(), value: isPresenting)
        case .hud:
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
                main()
                    .frame(maxWidth: screen.width, maxHeight: screen.height)
                    .offset(y: offset)
                    .animation(Animation.spring(), value: isPresenting)
            }
        case .alert:
            main()
                .frame(maxWidth: screen.width, maxHeight: screen.height, alignment: .center)
                .edgesIgnoringSafeArea(.all)
                .animation(Animation.spring(), value: isPresenting)
        }
    }
    
    @ViewBuilder public func main() -> some View {
        ZStack {
            if isPresenting {
                switch toastItem!.toast.displayMode {
                case .alert:
                    ToastAlertModifier(
                        toastItem!.toast as! ToastAlert,
                        isPresenting: $isPresenting,
                        tapToDismiss: tapToDismiss,
                        onTap: { toaster.dismiss() }
                    )
                case .hud:
                    ToastHUDModifier(
                        toastItem!.toast as! ToastHUD,
                        isPresenting: $isPresenting,
                        alertRect: $alertRect,
                        tapToDismiss: tapToDismiss,
                        onTap: { toaster.dismiss() }
                    )
                case .banner:
                    ToastBannerModifier(
                        toastItem!.toast as! ToastBanner,
                        isPresenting: $isPresenting,
                        tapToDismiss: tapToDismiss,
                        onTap: { toaster.dismiss() }
                    )
                }
            }
        }
        .offset(y: toastItem!.offsetY)
    }
    
}
