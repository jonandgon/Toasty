//
//  ToastHUD.swift
//  Toasty
//
//  Created by Sam Spencer on 11/7/22.
//  Licensed under the MIT License.
//

import SwiftUI

struct ToastHUD: View {
    
    /// The type content to display in the alert. Can be any ``AlertType``.
    ///
    var type: AlertType
    
    /// The title of the alert. *Optional*.
    ///
    var title: String? = nil
    
    /// The subtitle of the alert. *Optional*.
    ///
    var subTitle: String? = nil
    
    /// The appearance of the alert. Can be any ``AlertStyle``.
    ///
    var style: AlertStyle? = nil
    
    /// Initialize a new ``ToastBanner`` object.
    ///
    init(
        type: AlertType,
        title: String? = nil,
        subTitle: String? = nil,
        style: AlertStyle? = nil
    ) {
        self.type = type
        self.title = title
        self.subTitle = subTitle
        self.style = style
    }
    
    var body: some View {
        Group {
            HStack(spacing: 16) {
                iconComponent()
                if title != nil || subTitle != nil {
                    VStack(alignment: type == .regular ? .center : .leading, spacing: 2) {
                        titleComponent()
                        subtitleComponent()
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)
            .frame(minHeight: 50)
            .alertBackground(style?.backgroundColor ?? nil)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.gray.opacity(0.2), lineWidth: 1))
            .shadow(color: Color.black.opacity(0.075), radius: 10, x: 0, y: 3)
            .compositingGroup()
        }
        .padding(.top)
        .padding(.horizontal)
    }
    
    @ViewBuilder func iconComponent() -> some View {
        switch type {
        case .complete(let color):
            AnimatedCheckmark(color: color, size: 15)
        case .error(let color):
            AnimatedXmark(color: color, size: 15)
        case .systemImage(let name, let color):
            Image(systemName: name)
                .hudModifier()
                .foregroundColor(color)
        case .image(let name, let color):
            Image(name)
                .hudModifier()
                .foregroundColor(color)
        case .loading:
            ProgressView()
                .progressViewStyle(.circular)
        case .regular:
            EmptyView()
        }
    }
    
    @ViewBuilder func titleComponent() -> some View {
        if title != nil {
            Text(LocalizedStringKey(title ?? ""))
                .font(style?.titleFont ?? Font.body.bold())
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                .truncationMode(.middle)
                .textColor(style?.titleColor ?? nil)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder func subtitleComponent() -> some View {
        if subTitle != nil {
            Text(LocalizedStringKey(subTitle ?? ""))
                .font(style?.subTitleFont ?? Font.footnote)
                .opacity(0.7)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .textColor(style?.subtitleColor ?? nil)
        } else {
            EmptyView()
        }
    }
    
}

struct ToastHUD_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            ToastHUD(type: .regular, title: "Title", subTitle: "Subtitle")
            ToastHUD(type: .error(Color(.systemRed)), title: "Error", subTitle: "Something went wrong.", style: .none)
            ToastHUD(type: .complete(Color(.systemGreen)), title: "Success", subTitle: "Something completed successfully.", style: .none)
            ToastHUD(type: .systemImage("map.fill", Color(.systemCyan)), title: "This is a silly Toast HUD", subTitle: "Ooh here's some longer content down here which might be truncated, but we can't really be sure if it will be.", style: .none)
        }
    }
    
}
