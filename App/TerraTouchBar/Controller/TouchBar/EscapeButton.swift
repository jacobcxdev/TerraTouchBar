//
//  EscapeButton.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 15/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import SwiftUI

/// An `NSCustomTouchBarItem` subclass which controls an `EscapeView`.
class EscapeButton: NSCustomTouchBarItem {
    // MARK: - Properties

    /// The `TouchBarController` instance currently controlling the `EscapeButton`.
    weak var touchBarController: TouchBarController?

    /// The `EscapeView` instance to display in the `view` property.
    var escapeView: EscapeView!

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

    /// Performs setup operations on the `EscapeButton` instance.
    private func setup() {
        visibilityPriority = .high
        escapeView = EscapeView()
        let escapeViewController = NSHostingController(rootView: escapeView)
        view = escapeViewController.view
    }
}
