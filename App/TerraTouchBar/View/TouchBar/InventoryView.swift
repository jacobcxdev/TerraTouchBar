//
//  InventoryView.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 14/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import SwiftUI

/// A SwiftUI `View` which displays the `items` property of an `InventoryBar` instance.
struct InventoryView: View {
    // MARK: - Properties

    /// The `InventoryBar` instance containing the `items` to display.
    @ObservedObject var inventoryBar: InventoryBar

    /// The `StatsBar` instance stored in the `statsBar` property of the `TouchBarController` of the `inventoryBar`.
    private var statsBar: StatsBar? {
        inventoryBar.touchBarController?.statsBar
    }

    /// The `items` property of `inventoryBar`.
    private var items: [Item] {
        inventoryBar.items
    }

    var body: some View {
        if inventoryBar.stickyHotbar {
            return AnyView(
                HStack(spacing: 5) {
                    if items.count >= 10 {
                        HStack(spacing: 0) {
                            ForEach(0 ..< 10, id: \.self) { index in
                                HStack(spacing: 0) {
                                    ItemView(item: self.items[index], index: index)
                                        .padding(.horizontal, 5)
                                        .onTapGesture {
                                            self.select(atIndex: index)
                                    }
                                }
                            }
                        }
                        HStack(spacing: 10) {
                            Divider()
                            Divider()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(10 ..< self.items.count, id: \.self) { index in
                                    HStack(spacing: 0) {
                                        if index == 50 || index == 54 {
                                            Group {
                                                Divider()
                                                Divider()
                                            }
                                            .padding(.horizontal, 5)
                                        } else if index > 10 && index % 10 == 0 {
                                            Divider()
                                                .padding(.horizontal, 5)
                                        }
                                        ItemView(item: self.items[index], index: index)
                                            .padding(.horizontal, 5)
                                            .onTapGesture {
                                                // TODO: Swapping
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: 1000)
            )
        } else {
            return AnyView(
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< self.items.count, id: \.self) { index in
                            HStack(spacing: 0) {
                                if index == 10 || index == 50 || index == 54 {
                                    Group {
                                        Divider()
                                        Divider()
                                    }
                                    .padding(.horizontal, 5)
                                } else if index > 0 && index % 10 == 0 {
                                    Divider()
                                        .padding(.horizontal, 5)
                                }
                                ItemView(item: self.items[index], index: index)
                                    .padding(.horizontal, 5)
                                    .onTapGesture {
                                        if index < 10 {
                                            self.select(atIndex: index)
                                        } else {
                                            // TODO: Swapping
                                        }
                                }
                            }
                        }
                    }
                }
            )
        }
    }

    // MARK: - Init Methods

    /// Creates an instance of `InventoryView`.
    /// - Parameter inventoryBar: The `InventoryBar` instance containing the `items` to display.
    init(inventoryBar: InventoryBar) {
        self.inventoryBar = inventoryBar
    }

    // MARK: - Instance Methods

    /// Exclusively selects the `Item` in `items` at the index specified by the `index` parameter.
    /// - Parameter index: The index of the `Item` to select.
    private func select(atIndex index: Int) {
        items.enumerated().forEach { $1.isSelected = $0 == index }
        DispatchQueue.global().async {
            guard let message = TCPClientHandler.Message.hotbar(index: index) else {
                return
            }
            let client = TCPClient(
                host: Constants.clientAddress,
                port: Constants.clientPort,
                handler: TCPClientHandler(message: message)
            )
            do {
                try client.run()
            } catch {
                print(error)
            }
            client.shutdown()
        }
    }
}

// MARK: - Previews

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        let inventoryBar = InventoryBar(identifier: .inventoryBar)
        inventoryBar.items = []
        return InventoryView(inventoryBar: inventoryBar)
    }
}
