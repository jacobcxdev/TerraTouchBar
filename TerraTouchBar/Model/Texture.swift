//
//  Texture.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 15/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import Foundation
import SwiftyJSON

/// The texture of an item in Terraria.
struct Texture {
    // MARK: - Properties

    /// The PNG data of the texture.
    var data: Data

    /// The size of a single frame in the texture.
    var size: CGSize

    /// Whether the texture is animated.
    var isAnimated: Bool

    /// Whether the texture pulsates.
    var pulsates: Bool

    /// The number of frames in the texture.
    var frameCount: Int

    /// The number of ticks per frame when animating the texture.
    var ticksPerFrame: Int

    /// An `NSImageCycler` to cycle the frames in the texture.
    var imageCycler: NSImageCycler?

    /// The PNG data of the texture as an `NSImage`.
    var image: NSImage? {
        guard let image = NSImage(data: data) else {
            print("Error decoding image")
            return nil
        }
        image.size = size
        image.size.width *= 0.5
        image.size.height *= 0.5
        if image.size.width > 20 || image.size.height > 20 {
            let ratio = image.size.width / image.size.height
            let const: CGFloat = 20
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

    // MARK: - Init Methods

    /// Creates an instance of `Texture`.
    /// - Parameters:
    ///   - data: The PNG data of the texture.
    ///   - size: The size of a single frame in the texture.
    ///   - isAnimated: Whether the texture is animated.
    ///   - pulsates: Whether the texture pulsates.
    ///   - frameCount: The number of frames in the texture.
    ///   - ticksPerFrame: The number of ticks per frame when animating the texture.
    init(data: Data, size: CGSize, isAnimated: Bool, pulsates: Bool, frameCount: Int, ticksPerFrame: Int) {
        self.data = data
        self.size = size
        self.isAnimated = isAnimated
        self.pulsates = pulsates
        self.frameCount = frameCount
        self.ticksPerFrame = ticksPerFrame
        if isAnimated, let image = NSImage(data: data) {
            imageCycler = NSImageCycler(
                images: image.nsImageSlice(axis: .horizontal, slices: frameCount),
                delay: Constants.tps * Double(ticksPerFrame)
            )
        }
    }

    /// Creates an instance of `Texture` from a `JSON`.
    /// - Parameter json: A `JSON` containing keys for `data`, `width`, `height`, `isAnimated`, `pulsates`, `frameCount`, and `ticksPerFrame`.
    init(json: JSON) throws {
        guard let dataString = json["data"].string else {
            throw RuntimeError.error("Error decoding dataString")
        }
        guard let data = Data(base64Encoded: dataString) else {
            throw RuntimeError.error("Error decoding data")
        }
        guard let width = json["width"].float else {
            throw RuntimeError.error("Error decoding width")
        }
        guard let height = json["height"].float else {
            throw RuntimeError.error("Error decoding height")
        }
        guard let isAnimated = json["isAnimated"].bool else {
            throw RuntimeError.error("Error decoding isAnimated")
        }
        guard let pulsates = json["pulsates"].bool else {
            throw RuntimeError.error("Error decoding pulses")
        }
        guard let frameCount = json["frameCount"].int else {
            throw RuntimeError.error("Error decoding frameCount")
        }
        guard let ticksPerFrame = json["ticksPerFrame"].int else {
            throw RuntimeError.error("Error decoding ticksPerFrame")
        }
        self.init(
            data: data,
            size: CGSize(width: CGFloat(width), height: CGFloat(height)),
            isAnimated: isAnimated,
            pulsates: pulsates,
            frameCount:
            frameCount,
            ticksPerFrame: ticksPerFrame
        )
    }
}
