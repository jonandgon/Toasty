//
//  ToastProtocol.swift
//  Toasty
//
//  Created by Sam Spencer on 11/7/22.
//  Licensed under the MIT License.
//

import Foundation
import SwiftUI

public protocol Toast: View {
    
    /// The alert's display behavior.
    ///
    var displayMode: DisplayMode { get }
    
    /// The type content to display in the alert.
    ///
    var type: AlertType { get set }
    
    /// The title of the alert. Optional.
    ///
    var title: String? { get set }
    
    /// The subtitle of the alert. Optional.
    ///
    var subtitle: String? { get set }
    
    /// The appearance of the alert.
    ///
    var style: AlertStyle? { get set }
    
    /// Initialize a new ``Toast`` object.
    ///
    init(type: AlertType, title: String?, subtitle: String?, style: AlertStyle?)
    
}
