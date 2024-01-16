//
//  ToastQueueItem.swift
//  Toasty
//
//  Created by Sam Spencer on 11/7/22.
//  Licensed under the MIT License.
//

import Foundation

public class ToastQueueItem: Equatable, Identifiable {

    public var id: String
    public var toast: any Toast
    public var duration: TimeInterval
    public var allowsDismiss: Bool
    public var offsetY: CGFloat
    
    public init(toast: some Toast, duration: TimeInterval, allowsDismiss: Bool, offsetY: CGFloat) {
		self.id = UUID().uuidString;
        self.toast = toast
        self.duration = duration
        self.allowsDismiss = allowsDismiss
        self.offsetY = offsetY
    }
    
    public static func == (lhs: ToastQueueItem, rhs: ToastQueueItem) -> Bool {
        let sameDuration = (lhs.duration == rhs.duration)
        let sameBehavior = (lhs.allowsDismiss == rhs.allowsDismiss)
        let sameOffset = (lhs.offsetY == rhs.offsetY)
        let sameQueueParams = sameDuration && sameBehavior && sameOffset
        
        let sameToastTitle = (lhs.toast.title == rhs.toast.title)
        let sameToastSubtitle = (lhs.toast.subtitle == rhs.toast.subtitle)
        
        return sameQueueParams && sameToastTitle && sameToastSubtitle
    }
    
}
