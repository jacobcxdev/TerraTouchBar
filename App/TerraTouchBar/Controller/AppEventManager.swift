//
//  AppEventManager.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 13/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import Cocoa
import SwiftyJSON

/// An object which manages events for the application.
class AppEventManager {
    // MARK: - Properties

    /// A `TouchBarController` instance which controls an `NSTouchBar` instance.
    weak var touchBarController: TouchBarController?

    // MARK: - Init Methods

    /// Creates an instance of `AppEventManager`.
    init() {
        setup()
    }

    /// Creates an instance of `AppEventManager`, given a `TouchBarController`.
    /// - Parameter touchBarController: A `TouchBarController` instance which currently controls the Touch Bar.
    init(touchBarController: TouchBarController) {
        self.touchBarController = touchBarController
        setup()
    }

    // MARK: - Instance Methods

    /// Performs setup operations on the `AppEventManager` instance.
    private func setup() {
        NSWorkspace.shared.notificationCenter.addObserver(
            self,
            selector: #selector(currentAppChanged),
            name: NSWorkspace.didActivateApplicationNotification,
            object: nil
        )
    }

    /// Performs operations when the currently active application changes.
    @objc func currentAppChanged() {
        guard let touchBarController = touchBarController else {
            return
        }
        let activeApps = NSWorkspace.shared.runningApplications
        for app in activeApps where app.isActive {
            if app.bundleIdentifier == Bundle.main.bundleIdentifier {
                touchBarController.showTouchBar()
            } else if (app.executableURL?.absoluteString ?? "").contains("/mono") {
                touchBarController.showTouchBar()
            } else {
                touchBarController.hideTouchBar()
            }
            break
        }
    }

    /// Invokes update methods on relevant Touch Bar Items with a `JSON` object.
    /// - Parameter json: The `JSON` object to update with.
    func receivedUpdate(json: JSON) {
        try? touchBarController?.inventoryBar.updateItems(from: json["inventory"])
        try? touchBarController?.statsBar.updateStats(from: json["stats"])
    }
}
