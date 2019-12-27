//
//  Extensions.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 14/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import NIO

extension NSImage {
    // MARK: - Properties

    /// A `CGImage` representation of the `NSImage` instance.
    var cgImage: CGImage? {
        var proposedRect = CGRect(origin: .zero, size: size)
        return cgImage(forProposedRect: &proposedRect, context: nil, hints: nil)
    }

    // MARK: - Instance Methods

    /// Returns a `CGSize` instance equal to the size of a slice of the `NSImage` instance when slicing a given number of times along a given `SliceAxis`.
    /// - Parameters:
    ///   - axis: The `SliceAxis` to slice along.
    ///   - slices: The number of times to slice.
    /// - Returns:
    ///   - A `CGSize` instance.
    func sliceSize(axis: SliceAxis, slices: Int) -> CGSize {
        CGSize(
            width: axis == .horizontal ? size.width : size.width / CGFloat(slices),
            height: axis == .vertical ? size.height : size.height / CGFloat(slices)
        )
    }

    /// Returns an array of `CGImage` instances, each being a slice of the `NSImage` instance when slicing a given number of times along a given `SliceAxis`.
    /// - Parameters:
    ///   - axis: The `SliceAxis` to slice along.
    ///   - slices: The number of times to slice.
    ///   - sliceSize: The size of each slice.
    /// - Returns:
    ///   - An array of `CGImage` instances.
    func cgImageSlice(axis: SliceAxis, slices: Int, sliceSize: CGSize? = nil) -> [CGImage] {
        guard let cgImage = self.cgImage else {
            return []
        }
        let size = { [weak self] () -> CGSize in
            guard let self = self else {
                return .zero
            }
            return sliceSize == nil ? self.sliceSize(axis: axis, slices: slices) : sliceSize!
        }()
        var cgImageSlices = [CGImage]()
        var rect = CGRect(origin: .zero, size: size)
        for sliceIndex in 1 ... slices {
            if let cropped = cgImage.cropping(to: rect) {
                cgImageSlices.append(cropped)
            }
            rect.origin = CGPoint(x: 0, y: size.height * CGFloat(sliceIndex))
        }
        return cgImageSlices
    }

    /// Returns an array of `NSImage` instances, each being a slice of the `NSImage` instance when slicing a given number of times along a given `SliceAxis`.
    /// - Parameters:
    ///   - axis: The `SliceAxis` to slice along.
    ///   - slices: The number of times to slice.
    /// - Returns:
    ///   - An array of `NSImage` instances.
    func nsImageSlice(axis: SliceAxis, slices: Int) -> [NSImage] {
        let sliceSize = self.sliceSize(axis: axis, slices: slices)
        var images = [NSImage]()
        for cgImage in cgImageSlice(axis: axis, slices: slices, sliceSize: sliceSize) {
            images.append(NSImage(cgImage: cgImage, size: sliceSize))
        }
        return images
    }

    /// Scales the `NSImage` instance by a given multiplier, limited by a given length.
    /// - Parameters:
    ///   - scaleMultiplier: The scale multiplier.
    ///   - maxLength: The maximum length (width or height, whichever is greater).
    /// - Returns:
    ///   - An `NSImage` instance.
    func scaleEffect(_ scaleMultiplier: CGFloat, maxLength: CGFloat = .infinity) throws -> NSImage {
        guard let image = self.copy() as? NSImage else {
            throw RuntimeError.error("Error copying image")
        }
        image.size.width *= scaleMultiplier
        image.size.height *= scaleMultiplier
        if image.size.width > maxLength || image.size.height > maxLength {
            let ratio = image.size.width / image.size.height
            let const: CGFloat = maxLength
            if image.size.width >= image.size.height {
                image.size.width = const
                image.size.height = const / ratio
            } else {
                image.size.height = const
                image.size.width = const * ratio
            }
        }
        return image
    }

    // MARK: - Enums

    /// Axes along which an `NSImage` can be sliced.
    enum SliceAxis {
        case horizontal
        case vertical
    }
}
