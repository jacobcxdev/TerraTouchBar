//
//  Item.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 13/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import Foundation
import SwiftyJSON

/// An item in Terraria.
class Item: ObservableObject {
    // MARK: - Properties

    /// The name of the Terraria item.
    @Published var name: String

    /// The number of items in a stack.
    @Published var stack: Int

    /// Whether the item is currently useable.
    @Published var canUseItem: Bool

    /// Whether the item is selected.
    @Published var isSelected: Bool

    /// Whether the item is Air (a.k.a. empty).
    @Published var isAir: Bool

    /// The texture of the item.
    @Published var texture: Texture

    // MARK: - Init Methods

    /// Creates an instance of `Item`.
    /// - Parameters:
    ///   - name: The name of the Terraria item.
    ///   - stack: The number of items in a stack.
    ///   - canUseItem: Whether the item is currently useable.
    ///   - isSelected: Whether the item is selected.
    ///   - isAir: Whether the item is Air (a.k.a. empty).
    ///   - texture: The texture of the item.
    init(name: String, stack: Int, canUseItem: Bool, isSelected: Bool, isAir: Bool, texture: Texture) {
        self.name = name
        self.stack = stack
        self.canUseItem = canUseItem
        self.isSelected = isSelected
        self.isAir = isAir
        self.texture = texture
    }

    /// Creates an instance of `Item` from a `JSON`.
    /// - Parameter json: A `JSON` containing keys for `name`, `stack`, `canUseItem`, `isSelected`, `isAir`, and `texture`.
    convenience init(json: JSON) throws {
        guard let name = json["name"].string else {
            throw RuntimeError.error("Error decoding name")
        }
        guard let stack = json["stack"].int else {
            throw RuntimeError.error("Error decoding stack")
        }
        guard let canUseItem = json["canUseItem"].bool else {
            throw RuntimeError.error("Error decoding canUseItem")
        }
        guard let isSelected = json["isSelected"].bool else {
            throw RuntimeError.error("Error decoding isSelected")
        }
        guard let isAir = json["isAir"].bool else {
            throw RuntimeError.error("Error decoding isAir")
        }
        guard let texture = try? Texture(json: json["texture"]) else {
            throw RuntimeError.error("Error decoding texture")
        }
        self.init(
            name: name,
            stack: stack,
            canUseItem: canUseItem,
            isSelected: isSelected,
            isAir: isAir,
            texture: texture
        )
    }
}
