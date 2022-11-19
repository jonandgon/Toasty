//
//  TextForegroundModifier.swift
//  Toasty
//
//  Created by Sam Spencer on 11/7/22.
//  Licensed under the MIT License.
//

import Foundation
import SwiftUI

/// View Modifier to change foreground text color on ``Toast``
/// objects.
///
internal struct TextForegroundModifier: ViewModifier {
    
    var color: Color?
    
    @ViewBuilder func body(content: Content) -> some View {
        if color != nil {
            content
                .foregroundColor(color)
        } else {
            content
        }
    }
    
}
