//
//  ToastyDemoApp.swift
//  ToastyDemo
//
//  Created by Sam Spencer on 11/7/22.
//

import SwiftUI
import Toasty

@main
struct ToastyDemoApp: App {
    
    @StateObject var queue = Toaster.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .toaster(queue)
        }
    }
    
}
