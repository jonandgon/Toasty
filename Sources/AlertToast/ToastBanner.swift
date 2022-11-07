//
//  ToastBanner.swift
//  Toasty
//
//  Created by Sam Spencer on 11/7/22.
//  Licensed under the MIT License.
//

import SwiftUI

struct ToastBanner: View {
    
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
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    iconComponent()
                    Text(LocalizedStringKey(title ?? ""))
                        .font(style?.titleFont ?? Font.headline.bold())
                }
                
                if subTitle != nil {
                    Text(LocalizedStringKey(subTitle!))
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
            ToastBanner(type: .regular, title: "Generic Title", subTitle: "A longer generic subtitle.", style: AlertStyle(backgroundColor: Color(.systemYellow), titleColor: Color.white, subTitleColor: Color.white.opacity(0.8)))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 0)
            ToastBanner(type: .complete(Color(.systemGreen)), title: "Successfully Uploaded", subTitle: "Your content was successfully uploaded.")
            ToastBanner(type: .loading, title: "Preparing to Upload", subTitle: "Your content is being processed for upload.")
            ToastBanner(type: .error(Color(.systemRed)), title: "Failed to Upload", subTitle: "Your content failed to upload to the network.")
            ToastBanner(type: .systemImage("bolt.horizontal.fill", Color.yellow), title: "No Internet Connection", subTitle: "Unable to connect to the network. Please check your connection and try again.")
        }
    }
    
}
