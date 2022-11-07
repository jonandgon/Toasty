//
//  DisplayMode.swift
//  Toasty
//
//  Created by Sam Spencer on 11/7/22.
//  Licensed under the MIT License.
//

import Foundation

/// Determine how the alert will be displayed.
///
public enum DisplayMode: Equatable {
    
    /// Present at the center of the screen.
    ///
    case alert
    
    /// Drop from the top of the screen.
    ///
    case hud
    
    /// Banner from the bottom of the screen.
    ///
    case banner(_ transition: BannerAnimation)
    
}
