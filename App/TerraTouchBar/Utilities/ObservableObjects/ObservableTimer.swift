//
//  ObservableTimer.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 16/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import Foundation

/// An `ObservableObject` which publishes a change every time a `Timer` instance fires.
class ObservableTimer: ObservableObject {
    // MARK: - Properties

    /// The `Timer` instance to create the delay between published changes.
    private var timer: Timer!

    // MARK: - Init Methods

    /// Creates an instance of `ObservableTimer`.
    /// - Parameters:
    ///   - withTimeInterval: The `TimeInterval` between each published change.
    ///   - repeats: Whether the timer should repeat.
    init(withTimeInterval: TimeInterval, repeats: Bool) {
        timer = Timer.scheduledTimer(withTimeInterval: withTimeInterval, repeats: repeats) { [weak self] _ in
            self?.objectWillChange.send()
        }
    }

    deinit {
        timer.invalidate()
    }
}
