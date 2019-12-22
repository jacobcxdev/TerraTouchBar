//
//  NSImageCycler.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 16/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import Foundation

/// An observable object which cycles through an array of `NSImage` instances.
class NSImageCycler: ObservableObject {
    // MARK: - Properties

    /// The index of the currently displayed `NSImage` in the `images` property.
    @Published var index = 0

    /// The timer which creates the delay between displaying each `NSImage`.
    var timer = Timer()

    /// The array of `NSImage` instances to cycle through.
    var images = [NSImage]()

    /// The currently displayed `NSImage`.
    var image: NSImage {
        images[index]
    }

    // MARK: - Init Methods

    /// Creates an instance of `NSImageCycler`.
    /// - Parameters:
    ///   - images: The array of `NSImage` instances to cycle through.
    ///   - delay: The `TimeInterval` of the delay between displaying each `NSImage`.
    init(images: [NSImage], delay: TimeInterval) {
        self.images = images
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: true) { _ in
            if self.index < images.count - 1 {
                self.index += 1
            } else {
                self.index = 0
            }
        }
    }
}
