//
//  InventoryBar.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 13/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import SwiftUI
import SwiftyJSON

/// An `NSCustomTouchBarItem` subclass which controls an `InventoryView`.
class InventoryBar: NSCustomTouchBarItem, ObservableObject {
    // MARK: - Properties

    /// The `TouchBarController` instance currently controlling the `InventoryBar`.
    weak var touchBarController: TouchBarController?

    /// The `NSHostingView<InventoryView>` instance to display as the `view` property.
    var hostingView: NSHostingView<InventoryView>!

    /// An array of `Item` instances to display in the `InventoryView` which is stored in the `hostingView.rootView` property  — the inventory of the Terraria player.
    @Published var items = [Item]()

    /// Whether the hotbar of the `InventoryView` stored in the `hostingView.rootView` should be sticky.
    @Published var stickyHotbar: Bool! {
        didSet {
            UserDefaults.standard.set(stickyHotbar, forKey: Constants.shbKey)
        }
    }

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

    /// Performs setup operations on the `InventoryBar` instance.
    private func setup() {
        stickyHotbar = UserDefaults.standard.bool(forKey: Constants.shbKey)
        hostingView = NSHostingView(rootView: InventoryView(inventoryBar: self))
        view = hostingView
    }

    /// Updates the `items` property of the `InventoryBar` instance from a `JSON` object.
    /// - Parameter json: The `JSON` object to update with.
    func updateItems(from json: JSON) throws {
        guard json.null == nil else {
            throw RuntimeError.error("Error decoding json")
        }
        var buffer = [Item]()
        for item in json.arrayValue {
            do {
                buffer.append(try Item(json: item))
            } catch {
                print(error)
            }
        }
        items.removeAll()
        items.append(contentsOf: buffer)
    }
}
