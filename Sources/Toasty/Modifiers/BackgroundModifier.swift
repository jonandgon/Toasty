//
//  BackgroundModifier.swift
//  Toasty
//
//  Created by Sam Spencer on 11/7/22.
//  Licensed under the MIT License.
//

import Foundation
import SwiftUI

/// View Modifier to change the ``Toast`` background.
///
internal struct BackgroundModifier: ViewModifier {
    
    var color: Color?
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if color != nil {
            content
                .background(color)
        } else {
            content
                .background(Material.regular, in: Rectangle())
        }
    }
    
}
