//
//  View+Alert.swift
//  Toasty
//
//  Created by Sam Spencer on 11/7/22.
//  Licensed under the MIT License.
//

import Combine
import Foundation
import SwiftUI

// @available(iOS 13, macOS 11, *)
public extension View {
    
    /// Return a view with a maximum specific frame.
    ///
    /// Defaults to a maximum of frame of 175 x 175.
    ///
    internal func withFrame(_ withFrame: Bool) -> some View {
        modifier(WithFrameModifier(withFrame: withFrame))
    }
    
    /// Present an ``AlertToast/AlertToast``.
    ///
    /// - parameter show: A `Binding` to toggle and respond to presenation changes.
    /// - parameter duration: The number of seconds to display the toast.
    /// - parameter alert: A closure which supplies a custom ``AlertToast/AlertToast``.
    ///
    /// - returns: An ``AlertToast/AlertToast`` view.
    ///
    func toast(
        isPresenting: Binding<Bool>,
        duration: Double = 2,
        tapToDismiss: Bool = true,
        offsetY: CGFloat = 0,
        alert: @escaping () -> AlertToast,
        onTap: (() -> ())? = nil,
        completion: (() -> ())? = nil
    ) -> some View {
        modifier(AlertToastModifier(
            isPresenting: isPresenting,
            duration: duration,
            tapToDismiss: tapToDismiss,
            offsetY: offsetY,
            alert: alert,
            onTap: onTap,
            completion: completion
        ))
    }
    
    /// Set the ``AlertToast/AlertToast`` background.
    ///
    /// - parameter color: An optional color. If `nil`, uses a background `Material`.
    /// - returns: An ``AlertToast/AlertToast`` with a background.
    ///
    internal func alertBackground(_ color: Color? = nil) -> some View {
        modifier(BackgroundModifier(color: color))
    }
    
    /// Set the alert background
    ///
    /// - parameter color: An optional color. If `nil`, uses `.black`/`.white` depending
    ///   on the system theme.
    /// - returns: An ``AlertToast/AlertToast`` with updated text color.
    ///
    internal func textColor(_ color: Color? = nil) -> some View {
        modifier(TextForegroundModifier(color: color))
    }
    
    @ViewBuilder
    internal func valueChanged<T: Equatable>(value: T, onChange: @escaping (T) -> Void) -> some View {
        if #available(iOS 14.0, *) {
            self.onChange(of: value, perform: onChange)
        } else {
            self.onReceive(Just(value)) { (value) in
                onChange(value)
            }
        }
    }
    
}
