//
//  AlertStyle.swift
//  Toasty
//
//  Created by Sam Spencer on 11/7/22.
//  Licensed under the MIT License.
//

import Foundation
import SwiftUI

/// Customize certain aspects of an ``AlertToast/AlertToast``'s appearance.
///
public struct AlertStyle {
    
    public init(
        backgroundColor: Color? = nil,
        titleColor: Color? = nil,
        subTitleColor: Color? = nil,
        titleFont: Font? = nil,
        subTitleFont: Font? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.subtitleColor = subTitleColor
        self.titleFont = titleFont
        self.subTitleFont = subTitleFont
    }
    
    /// Alert background color
    ///
    var backgroundColor: Color?
    
    /// Alert title color
    ///
    var titleColor: Color?
    
    /// Alert subtitle color
    ///
    var subtitleColor: Color?
    
    /// Alert title font
    ///
    var titleFont: Font?
    
    /// Alert subtitle font
    ///
    var subTitleFont: Font?
    
}
