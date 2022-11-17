//
//  ToastAlert.swift
//  Toasty
//
//  Created by Sam Spencer on 11/7/22.
//  Licensed under the MIT License.
//

import SwiftUI

public struct ToastAlert: Toast {
    
    public var displayMode: DisplayMode {
        return .alert
    }
    
    public var type: AlertType
    public var title: String? = nil
    public var subtitle: String? = nil
    public var style: AlertStyle? = nil
    
    public init(
        type: AlertType,
        title: String? = nil,
        subtitle: String? = nil,
        style: AlertStyle? = nil
    ) {
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.style = style
    }
    
    public var body: some View {
        VStack {
            iconComponent()
            VStack(spacing: type == .regular ? 8 : 2) {
                if title != nil {
                    Text(LocalizedStringKey(title ?? ""))
                        .font(style?.titleFont ?? Font.body.bold())
                        .multilineTextAlignment(.center)
                        .textColor(style?.titleColor ?? nil)
                }
                if subtitle != nil {
                    Text(LocalizedStringKey(subtitle ?? ""))
                        .font(style?.subTitleFont ?? Font.footnote)
                        .opacity(0.7)
                        .multilineTextAlignment(.center)
                        .textColor(style?.subtitleColor ?? nil)
                }
            }
        }
        .padding()
        .withFrame(type != .regular && type != .loading)
        .alertBackground(style?.backgroundColor ?? nil)
        .cornerRadius(10)
    }
    
    @ViewBuilder func iconComponent() -> some View {
        switch type {
        case .complete(let color):
            Spacer()
            AnimatedCheckmark(color: color)
            Spacer()
        case .error(let color):
            Spacer()
            AnimatedXmark(color: color)
            Spacer()
        case .systemImage(let name, let color):
            Spacer()
            Image(systemName: name)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .foregroundColor(color)
                .padding(.bottom)
            Spacer()
        case .image(let name, let color):
            Spacer()
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .foregroundColor(color)
                .padding(.bottom)
            Spacer()
        case .loading:
            ProgressView()
                .progressViewStyle(.circular)
        case .regular:
            EmptyView()
        }
    }
    
}

struct ToastAlert_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            ToastAlert(type: .regular, title: "Generic Title", subtitle: "Generic longer subtitle content.")
            ToastAlert(type: .error(Color(.systemRed)), title: "Error", subtitle: "Something went wrong.", style: .none)
            ToastAlert(type: .complete(Color(.systemGreen)), title: "Success", subtitle: "Something completed successfully.", style: .none)
        }
    }
    
}
