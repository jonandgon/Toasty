//
//  AlertType.swift
//  Toasty
//
//  Created by Sam Spencer on 11/7/22.
//  Licensed under the MIT License.
//

import Foundation
import SwiftUI

/// Determine what the alert will display.
///
public enum AlertType: Equatable {
    
    /// Animated checkmark
    ///
    case complete(_ color: Color)
    
    /// Animated xmark
    ///
    case error(_ color: Color)
    
    /// System image (any valid SFSymbol)
    ///
    case systemImage(_ name: String, _ color: Color)
    
    /// Image from an assets bundle
    ///
    case image(_ name: String, _ color: Color)
    
    /// Circular loading indicator
    ///
    case loading
    
    /// Text-only alert
    ///
    case regular
    
}
