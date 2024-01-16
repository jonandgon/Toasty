//
//  Toaster.swift
//  Toasty
//
//  Created by Sam Spencer on 11/7/22.
//  Licensed under the MIT License.
//

import Combine
import Foundation

public class Toaster: ObservableObject {
    
    @Published public var queue: [ToastQueueItem] = []
    @Published public var current: ToastQueueItem?
    
    public static let shared: Toaster = Toaster()
    public let presentationDelay: TimeInterval = 0.5
    
    private var cancellables: Set<AnyCancellable> = []
    private var displayTimer: Timer?
    
    private init() {
        setupObserving()
    }
    
    // MARK: - Add to Queue
    
    public func addToQueue(_ toast: some Toast, duration: TimeInterval = 2, tapToDismiss: Bool = true, offsetY: CGFloat = 0) {
        let queueItem = ToastQueueItem(toast: toast, duration: duration, allowsDismiss: tapToDismiss, offsetY: offsetY)
        addToQueue(queueItem)
    }
    
    public func addToQueue(_ toastQueueItem: ToastQueueItem) {
        queue.append(toastQueueItem)
    }
    
    // MARK: - Remove from Queue
    
    public func dismiss() {
        displayTimer?.invalidate()
        current = nil
    }
    
    // MARK: - Observing
    
    private func setupObserving() {
        $queue
            .dropFirst()
//            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.showNext()
            }
            .store(in: &cancellables)
        
        $current
            .dropFirst()
//            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { [weak self] updatedCurrent in
                guard let self = self else { return }
                if let updatedCurrent {
                    self.startTimer(toastItem: updatedCurrent)
                } else {
                    self.showNext(delay: self.presentationDelay)
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Queue Management
    
    private func showNext(delay: TimeInterval = .zero) {
        guard delay != .zero else {
            Task {
                await showNextFromQueue()
            }
            return
        }
        
        Task {
            let delayInSeconds = UInt64(delay)
            let delayInNanoseconds = delayInSeconds * 1_000_000_000
            try? await Task.sleep(nanoseconds: delayInNanoseconds)
            await showNextFromQueue()
        }
    }
    
    @MainActor private func showNextFromQueue() {
        if current == nil, let next = queue.first {
            current = next
            queue.removeFirst()
        }
    }
    
    // MARK: - Queue Timing
    
    private func startTimer(toastItem: ToastQueueItem) {
        displayTimer = Timer.scheduledTimer(withTimeInterval: toastItem.duration, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            if let current = self.current, current.id == toastItem.id {
                self.dismiss()
            }
        }
    }
    
}
