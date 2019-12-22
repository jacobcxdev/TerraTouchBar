//
//  AnimatedImageView.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 16/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import SwiftUI

/// A SwiftUI `View` which displays an image being cycled by an `NSImageCycler`.
struct AnimatedImageView: View {
    // MARK: - Properties

    /// The `NSImageCycler`to cycle the displayed image.
    @ObservedObject var imageCycler: NSImageCycler

    /// The scale of the displayed image.
    @ObservedObject var scale: Scale

    var body: some View {
        do {
            return AnyView(Image(nsImage: try imageCycler.image.scaleEffect(scale.multiplier, maxLength: scale.maxLength)))
        } catch {
            print(error)
            return AnyView(EmptyView())
        }
    }

    // MARK: - Init Methods

    /// Creates an instance of `AnimatedImageView`.
    /// - Parameters:
    ///   - imageCycler: The `NSImageCycler`to cycle the displayed image.
    ///   - scale: The scale of the displayed image.
    init(imageCycler: NSImageCycler, scale: Scale) {
        self.imageCycler = imageCycler
        self.scale = scale
    }
}
