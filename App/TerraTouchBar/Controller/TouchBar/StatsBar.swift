//
//  StatsBar.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 20/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import TinyConstraints

/// An `NSCustomTouchBarItem` subclass which controls an `StatsView`.
class StatsBar: NSCustomTouchBarItem, ObservableObject, ObservedViewFrameDelegate {
    // MARK: - Properties

    /// The `TouchBarController` instance currently controlling the `InventoryBar`.
    weak var touchBarController: TouchBarController?

    /// The `ObservedViewFrameHostingView<StatsView>` instance to display as the `view` property.
    var hostingView: ObservedViewFrameHostingView<StatsView>!

    /// The maximum life for the Terraria player.
    @Published var maxLife: Double = 0

    /// The current life for the Terraria player.
    @Published var currentLife: Double = 0

    /// The maximum mana for the Terraria player.
    @Published var maxMana: Double = 0

    /// The current mana for the Terraria player.
    @Published var currentMana: Double = 0

    /// The style of the `StatsView` instance stored in the `hostingView.rootView` property, dictating the components to display.
    @ObservedObject var style = StatsViewStyle()

    // MARK: - Init Methods

    override init(identifier: NSTouchBarItem.Identifier) {
        super.init(identifier: identifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Instance Methods

    /// Performs setup operations on the `StatsBar` instance.
    private func setup() {
        visibilityPriority = .high
        hostingView = ObservedViewFrameHostingView(rootView: StatsView(statsBar: self))
        hostingView.delegate = self
        view = hostingView
    }

    /// Updates the stats properties of the `StatsBar` instance from a `JSON` object.
    /// - Parameter json: The `JSON` object to update with.
    func updateStats(from json: JSON) throws {
        try? updateLife(from: json["life"])
        try? updateMana(from: json["mana"])
    }

    /// Updates the `maxLife` and `currentLife` properties of the `StatsBar` instance from a `JSON` object.
    /// - Parameter json: The `JSON` object to update with.
    func updateLife(from json: JSON) throws {
        guard let max = json["max"].double else {
            throw RuntimeError.error("Error decoding max")
        }
        guard let current = json["current"].double else {
            throw RuntimeError.error("Error decoding current")
        }
        maxLife = max
        currentLife = current
    }

    /// Updates the `maxMana` and `currentMana` properties of the `StatsBar` instance from a `JSON` object.
    /// - Parameter json: The `JSON` object to update with.
    func updateMana(from json: JSON) throws {
        guard let max = json["max"].double else {
            throw RuntimeError.error("Error decoding max")
        }
        guard let current = json["current"].double else {
            throw RuntimeError.error("Error decoding current")
        }
        maxMana = max
        currentMana = current
    }

    // MARK: - Delegate Methods

    func viewFrameDidUpdate(frame: CGRect) {
        guard let inventoryBar = touchBarController?.inventoryBar else {
            return
        }
        inventoryBar.view.constraints.forEach {
            if $0.firstAttribute == .width {
                inventoryBar.view.removeConstraint($0)
            }
        }
        inventoryBar.view.width(1000 - frame.width)
    }
}
