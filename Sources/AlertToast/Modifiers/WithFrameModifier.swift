//
//  WithFrameModifier.swift
//  Toasty
//
//  Created by Sam Spencer on 11/7/22.
//  Licensed under the MIT License.
//

import Foundation
import SwiftUI

/// View Modifier for dynamic frame when ``AlertToast/AlertToast/AlertType`` is
/// ``AlertToast/AlertToast/AlertType/regular`` or
/// ``AlertToast/AlertToast/AlertType/loading``.
///
internal struct WithFrameModifier: ViewModifier {
    
    var withFrame: Bool
    
    var maxWidth: CGFloat = 175
    var maxHeight: CGFloat = 175
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if withFrame {
            content
                .frame(maxWidth: maxWidth, maxHeight: maxHeight, alignment: .center)
        } else {
            content
        }
    }
    
}
