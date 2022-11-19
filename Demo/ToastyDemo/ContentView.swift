//
//  ContentView.swift
//  ToastyDemo
//
//  Created by Sam Spencer on 11/7/22.
//

import SwiftUI
import Toasty

struct ContentView: View {
    
    @StateObject var toaster = Toaster.shared
    
    @State var bannerPresented: Bool = false
    @State var hudPresented: Bool = false
    @State var alertPresented: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    bannerToggle()
                    hudToggle()
                    alertToggle()
                }
                .padding()
            }
            .navigationTitle("Toast Demo")
        }
        .toast(isPresenting: $hudPresented, duration: 5) {
            ToastHUD(type: .error(Color(.systemRed)), title: "Error", subtitle: "Something went wrong.")
        }
        .toast(isPresenting: $alertPresented, duration: 5) {
            ToastAlert(type: .loading, title: "Loading", subtitle: "Preparing something for display...", style: .none)
        }
    }
    
    func bannerToggle() -> some View {
        Button {
            let banner = ToastBanner(
                type: .systemImage("bubbles.and.sparkles", Color(.systemTeal)),
                title: "Toasting it up",
                subtitle: "Notification \(UUID().uuidString)",
                style: .none
            )
            toaster.addToQueue(banner, duration: 5)
            // bannerPresented.toggle()
        } label: {
            HStack {
                Spacer()
                Text("Present Toast Banner")
                    .bold()
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding()
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color(.systemTeal))
        }
    }
    
    func hudToggle() -> some View {
        Button {
            hudPresented.toggle()
        } label: {
            HStack {
                Spacer()
                Text("Present Toast HUD")
                    .bold()
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding()
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color(.systemRed))
        }
    }
    
    func alertToggle() -> some View {
        Button {
            alertPresented.toggle()
        } label: {
            HStack {
                Spacer()
                Text("Present Toast Alert")
                    .bold()
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding()
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color(.systemIndigo))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
