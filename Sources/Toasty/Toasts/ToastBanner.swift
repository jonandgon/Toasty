//
//  ToastBanner.swift
//  Toasty
//
//  Created by Sam Spencer on 11/7/22.
//  Licensed under the MIT License.
//

import SwiftUI

public struct ToastBanner: Toast {
    
    public var displayMode: DisplayMode {
        return .banner(.pop)
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
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    iconComponent()
                    Text(LocalizedStringKey(title ?? ""))
                        .font(style?.titleFont ?? Font.headline.bold())
                }
                
                if subtitle != nil {
                    Text(LocalizedStringKey(subtitle!))
                        .font(style?.subTitleFont ?? Font.subheadline)
                        .lineLimit(2)
                        .truncationMode(.tail)
                }
            }
            .multilineTextAlignment(.leading)
            .textColor(style?.titleColor ?? nil)
            .padding()
            .frame(maxWidth: 400, alignment: .leading)
            .alertBackground(style?.backgroundColor ?? nil)
            .cornerRadius(10)
            .padding([.horizontal, .bottom])
        }
    }
    
    @ViewBuilder func iconComponent(with size: Int = 12) -> some View {
        switch type {
        case .complete(let color):
            AnimatedCheckmark(color: color, size: size)
        case .error(let color):
            AnimatedXmark(color: color, size: size)
        case .systemImage(let name, let color):
            Image(systemName: name)
                .foregroundColor(color)
        case .image(let name, let color):
            Image(name)
                .foregroundColor(color)
        case .loading:
            ProgressView()
                .progressViewStyle(.circular)
        case .regular:
            EmptyView()
        }
    }
    
}

struct ToastBanner_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            ToastBanner(type: .regular, title: "Generic Title", subtitle: "A longer generic subtitle.", style: AlertStyle(backgroundColor: Color(.systemYellow), titleColor: Color.white, subTitleColor: Color.white.opacity(0.8)))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 0)
            ToastBanner(type: .complete(Color(.systemGreen)), title: "Successfully Uploaded", subtitle: "Your content was successfully uploaded.")
            ToastBanner(type: .loading, title: "Preparing to Upload", subtitle: "Your content is being processed for upload.")
            ToastBanner(type: .error(Color(.systemRed)), title: "Failed to Upload", subtitle: "Your content failed to upload to the network.")
            ToastBanner(type: .systemImage("bolt.horizontal.fill", Color.yellow), title: "No Internet Connection", subtitle: "Unable to connect to the network. Please check your connection and try again.")
        }
    }
    
}
