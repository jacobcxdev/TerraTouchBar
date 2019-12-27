//
//  Constants.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 16/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import Foundation

/// A `struct` which declares various constants for the application.
struct Constants {
    // MARK: - Terraria

    /// Terraria runs at 60 ticks per second. Therefore, the length of time, in seconds, for a single tick is 1/60th of a second.
    static let tps: Double = 1 / 60

    /// The total possible number of hearts.
    static let totalHearts: Double = 20

    /// The total life held by one heart.
    static let heartCapacity: Double = 20

    /// The total mana held by one mana star.
    static let manaCapacity: Double = 20

    /// The maximum life a Terraria player can hold without consuming any life fruit.
    static let maxNonGoldLife: Double = 400

    // MARK: - TCP

    /// The address for the TerraTouchBar app server.
    static let serverAddress = "127.0.0.1"

    /// The address for the TerraTouchBar app client.
    static let clientAddress = "127.0.0.1"

    /// The port for the TerraTouchBar app server.
    static let serverPort = 1717

    /// The port for the TerraTouchBar app client.
    static let clientPort = 1718

    // MARK: - UserDefaults

    /// The key for the saved `StatsView.ViewComponent` value.
    static let svcKey = "statsViewComponents"
}
