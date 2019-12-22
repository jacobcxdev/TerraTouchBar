//
//  TouchBarController.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 13/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import Foundation

/// An object which controls an `NSTouchBar` instance.
class TouchBarController: NSObject, NSTouchBarDelegate {
    // MARK: - Properties

    /// The `NSTouchBar` instance to control.
    var touchBar = NSTouchBar()

    /// An `EscapeButton` instance to display.
    var escapeButton = EscapeButton(identifier: .escapeButton)

    /// An `InventoryBar` instance to display.
    var inventoryBar = InventoryBar(identifier: .inventoryBar)

    /// An `StatsBar` instance to display.
    var statsBar = StatsBar(identifier: .statsBar)

    // MARK: - Init Methods

    override init() {
        super.init()
        setup()
    }

    // MARK: - Instance Methods

    /// Performs setup operations on the `TouchBarController` instance.
    private func setup() {
        touchBar.defaultItemIdentifiers = [.escapeButton, .inventoryBar, .flexibleSpace, .statsBar]
        touchBar.delegate = self
        escapeButton.touchBarController = self
        inventoryBar.touchBarController = self
        statsBar.touchBarController = self
    }

    /// Presents the `NSTouchBar` instance stored in the `touchBar` property via private `NSTouchBar` methods.
    func showTouchBar() {
        NSTouchBar.presentSystemModalTouchBar(touchBar, placement: 1, systemTrayItemIdentifier: .terraTouchBar)
    }

    /// Dismisses the `NSTouchBar` instance stored in the `touchBar` property via private `NSTouchBar` methods.
    func hideTouchBar() {
        NSTouchBar.dismissSystemModalTouchBar(touchBar)
    }

    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        switch identifier {
        case .escapeButton:
            return escapeButton
        case .inventoryBar:
            return inventoryBar
        case .statsBar:
            return statsBar
        case .flexibleSpace:
            return touchBar.item(forIdentifier: .flexibleSpace)
        default:
            return nil
        }
    }
}
