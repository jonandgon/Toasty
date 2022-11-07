//
//  AlertToast.swift
//  Toasty
//
//  Created by Elai Zubermanon 2/14/2021.
//  Licensed under the MIT License.
//

import SwiftUI

public struct AlertToast: View {
    
    /// The alert's display behavior. Can be any ``DisplayMode``. Defaults to
    /// ``DisplayMode/alert``.
    ///
    public var displayMode: DisplayMode = .alert
    
    /// The type content to display in the alert. Can be any ``AlertType``.
    ///
    public var type: AlertType
    
    /// The title of the alert. Optional.
    ///
    public var title: String? = nil
    
    /// The subtitle of the alert. Optional.
    ///
    public var subTitle: String? = nil
    
    /// The appearance of the alert. Can be any ``AlertStyle``.
    ///
    public var style: AlertStyle? = nil
    
    /// Initialize a new ``AlertToast`` object.
    ///
    public init(
        displayMode: DisplayMode = .alert,
        type: AlertType,
        title: String? = nil,
        subTitle: String? = nil,
        style: AlertStyle? = nil
    ) {
        self.displayMode = displayMode
        self.type = type
        self.title = title
        self.subTitle = subTitle
        self.style = style
    }
    
    public var body: some View {
        switch displayMode {
        case .alert: ToastAlert(type: type, title: title, subTitle: subTitle, style: style)
        case .hud: ToastHUD(type: type, title: title, subTitle: subTitle, style: style)
        case .banner: ToastBanner(type: type, title: title, subTitle: subTitle, style: style)
        }
    }
    
}
