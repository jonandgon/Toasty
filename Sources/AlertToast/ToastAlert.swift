//
//  ToastAlert.swift
//  Toasty
//
//  Created by Sam Spencer on 11/7/22.
//  Licensed under the MIT License.
//

import SwiftUI

struct ToastAlert: View {
    
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
        VStack {
            iconComponent()
            VStack(spacing: type == .regular ? 8 : 2) {
                if title != nil {
                    Text(LocalizedStringKey(title ?? ""))
                        .font(style?.titleFont ?? Font.body.bold())
                        .multilineTextAlignment(.center)
                        .textColor(style?.titleColor ?? nil)
                }
                if subTitle != nil {
                    Text(LocalizedStringKey(subTitle ?? ""))
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
            ToastAlert(type: .regular, title: "Generic Title", subTitle: "Generic longer subtitle content.")
            ToastAlert(type: .error(Color(.systemRed)), title: "Error", subTitle: "Something went wrong.", style: .none)
            ToastAlert(type: .complete(Color(.systemGreen)), title: "Success", subTitle: "Something completed successfully.", style: .none)
        }
    }
    
}
