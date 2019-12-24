//
//  ItemView.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 16/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import SwiftUI

/// A SwiftUI `View` which displays an `Item` instance.
struct ItemView: View {
    // MARK: - Properties

    /// The scale of the pulsating texture.
    @State private var texturePulseScale: CGFloat = 1

    /// The displayed `Item` instance.
    @ObservedObject var item: Item

    /// The index of the `Item` instance in the `items` property of the `Item` instance's `InventoryBar`.
    var index: Int

    /// The `ObservableTimer` instance for creating the pulsating texture's pulsation delay.
    var timer = ObservableTimer(withTimeInterval: 0.5, repeats: true)

    var body: some View {
        ZStack(alignment: .topLeading) {
            ZStack(alignment: .bottomLeading) {
                ZStack {
                    Image(item.isSelected ? "inventory2" : "inventory")
                        .opacity(index < 10 ? 1 : 0.5)
                    textureImage(scale: Scale(multiplier: 0.5, maxLength: 20))
                        .scaleEffect(item.texture.pulsates ? self.texturePulseScale : 1)
                        .animation(.easeInOut(duration: 0.5))
                        .onReceive(timer.objectWillChange) { _ in
                            self.texturePulseScale = self.texturePulseScale > 1 ? 0.8 : 1.2
                    }
                }
                if item.stack > 1 {
                    andyText("\(item.stack)")
                        .padding(.leading, 4)
                        .padding(.bottom, 4)
                }
            }
            if index < 10 {
                andyText("\(index < 9 ? index + 1 : 0)")
                    .padding(.leading, 4)
                    .padding(.top, 4)
            }
        }
        .overlay({ () -> AnyView? in
            if !item.canUseItem {
                return AnyView(Image("cooldown"))
            }
            return nil
        }())
        .scaleEffect(item.isSelected ? 1.1 : 1)
        .animation(.spring(response: 0.2, dampingFraction: 0.825, blendDuration: 0))
    }

    // MARK: - Init Methods

    /// Creates an instance of `ItemView`.
    /// - Parameters:
    ///   - item: The `Item` instance to display.
    ///   - index: The index of the `Item` instance in the `items` property of the `Item` instance's `InventoryBar`.
    init(item: Item, index: Int) {
        self.item = item
        self.index = index
    }

    // MARK: - Instance Methods

    /// Returns the displayed image in the form of a SwiftUI `View`.
    /// - Parameters:
    ///   - scale: The scale of the displayed image.
    /// - Returns:
    ///   - A SwiftUI `View`.
    private func textureImage(scale: Scale = Scale()) -> some View {
        guard !item.isAir else {
            return AnyView(EmptyView())
        }
        guard let image = NSImage(data: item.texture.data) else {
            print("Error converting data to image")
            return AnyView(EmptyView())
        }
        if item.texture.isAnimated, let imageCycler = item.texture.imageCycler {
            return AnyView(AnimatedImageView(imageCycler: imageCycler, scale: scale))
        } else if item.texture.isAnimated,
            let image = image.nsImageSlice(axis: .horizontal, slices: item.texture.frameCount).first {
            return AnyView(Image(nsImage: image))
        } else if item.texture.isAnimated {
            print("Error converting animated texture")
            return AnyView(EmptyView())
        }
        do {
            return AnyView(Image(nsImage: try image.scaleEffect(scale.multiplier, maxLength: scale.maxLength)))
        } catch {
            print(error)
        }
        return AnyView(EmptyView())
    }

    /// Returns a SwiftUI `Text` view, styled with the `andy` font.
    /// - Parameter text: The string to be displayed inside the `Text` view.
    /// - Returns:
    ///   - A SwiftUI `View`.
    private func andyText(_ text: String) -> some View {
        return Text(text)
            .font(.custom("andy", size: 8))
            .scaleEffect(item.isSelected ? 1.1 : 1)
            .shadow(color: .black, radius: 1)
            .shadow(color: .black, radius: 1)
    }
}
