//
//  Stats.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 20/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import SwiftUI

/// A SwiftUI `View` which displays the statistics stored in a `StatsBar` instance.
struct StatsView: View {
    // MARK: - Properties

    /// The `StatsBar` instance containing the stats to display.
    @ObservedObject var statsBar: StatsBar

    /// The style of the `StatsView`, dictating the components to display.
    @ObservedObject var style: StatsViewStyle

    /// The scale of the currently pulsating sprite.
    @State private var statsPulseScale: CGFloat = 1

    /// The `ObservableTimer` instance for creating the currently pulsating sprite's pulsation delay.
    var timer = ObservableTimer(withTimeInterval: 0.5, repeats: true)

    var body: some View {
            bodyView()
                .onReceive(timer.objectWillChange, perform: { _ in
                    self.statsPulseScale = self.statsPulseScale > 1 ? 0.8 : 1.2
                })
    }

    // MARK: - Init Methods

    /// Creates an instance of `StatsView`.
    /// - Parameters:
    ///   - statsBar: The `StatsBar` instance containing the stats to display.
    ///   - components: The components which should be displayed.
    init(statsBar: StatsBar, components: ViewComponent) {
        self.statsBar = statsBar
        self.style = StatsViewStyle(components: components)
    }

    // MARK: - Instance Methods

    /// Returns the number of golden hearts.
    /// - Returns:
    ///   - The number of golden hearts, as an `Int`.
    private func goldenHeartCount() -> Int {
        let lifeAboveMax = statsBar.maxLife - Constants.maxNonGoldLife
        return lifeAboveMax > 0 && lifeAboveMax.truncatingRemainder(dividingBy: 5) == 0 ? Int(lifeAboveMax / 5) : 0
    }

    /// Returns the capacity of each sprite for a given component.
    /// - Parameter component: The `StatsComponent` to use.
    /// - Returns:
    ///   - Returns the capacity of each sprite, as a `Double?`.
    private func spriteCapacity(component: StatsComponent) -> Double? {
        guard statsBar.maxLife > 0 else {
            return nil
        }
        switch component {
        case .life:
            return statsBar.maxLife / Constants.totalHearts
        case .mana:
            return Constants.manaCapacity
        }
    }

    /// Returns the number of sprites for a given component.
    /// - Parameter component: The `StatsComponent` to use.
    /// - Returns:
    ///   - Returns the number of sprites, as a `Double?`.
    private func numberOfSprites(component: StatsComponent) -> Double? {
        guard let spriteCapacity = spriteCapacity(component: component) else {
            return nil
        }
        switch component {
        case .life:
            return statsBar.maxLife / spriteCapacity
        case .mana:
            return statsBar.maxMana / spriteCapacity
        }
    }

    /// Returns the range of sprites for a given component and `RangeHalf`.
    /// - Parameters:
    ///   - component: The `StatsComponent` to use.
    ///   - half: Which half of the range to return.
    /// - Returns:
    ///   - The range of sprites for a given component, as an instance of `Range<Int>`.
    private func rangeForComponent(_ component: StatsComponent, half: RangeHalf? = nil) -> Range<Int> {
        let nSprites = numberOfSprites(component: component) ?? 0
        guard nSprites > 0 else {
            return 0 ..< 0
        }
        switch component {
        case .life:
            switch half {
            case .beggining:
                return 0 ..< Int(ceil(nSprites / 2))
            case .end:
                return Int(ceil(nSprites / 2)) ..< Int(nSprites)
            default:
                return 0 ..< Int(nSprites)
            }
        case .mana:
            switch half {
            case .beggining:
                return 0 ..< Int(ceil(nSprites / 2))
            case .end:
                return Int(ceil(nSprites / 2)) ..< Int(nSprites)
            default:
                return 0 ..< Int(nSprites)
            }
        }
    }

    /// Returns an array containing `(String, Int)` tuples, where the `String` is the name of a sprite in the `Assets.xcassets` bundle and the `Int` is the index of the sprite in the component, for a given component and `RangeHalf`.
    /// - Parameters:
    ///   - component: The `StatsComponent` to use.
    ///   - rangeHalf: Which half of the range to return.
    /// - Returns:
    ///   - An array containing `(String, Int)` tuples, where the `String` is the name of a sprite in the `Assets.xcassets` bundle and the `Int` is the index of the sprite in the component.
    private func spriteTuples(component: StatsComponent, rangeHalf: RangeHalf? = nil) -> [(String, Int)] {
        var names = [(String, Int)]()
        switch component {
        case .life:
            let goldenCount = goldenHeartCount()
            rangeForComponent(component, half: rangeHalf).forEach { names.append(($0 < goldenCount ? "heart2" : "heart", $0)) }
        case .mana:
            rangeForComponent(component, half: rangeHalf).forEach { names.append(("mana", $0)) }
        }
        return names
    }

    /// Returns a row of sprites in the form of a SwiftUI `View`.
    /// - Parameters:
    ///   - component: The `StatsComponent` to use.
    ///   - currentStat: The current stat value.
    ///   - spriteTuples: An array containing `(String, Int)` tuples, where the `String` is the name of a sprite in the `Assets.xcassets` bundle and the `Int` is the index of the sprite in the component.
    ///   - spriteScaleMultiplier: The scale multiplier for each sprite.
    ///   - maxSpriteLength: The maximum length of each sprite (width or height, whichever is greater).
    /// - Returns:
    ///   - A SwiftUI `View`.
    private func spritesRow(component: StatsComponent, currentStat: Double, spriteTuples: [(String, Int)], spriteScaleMultiplier: CGFloat, maxSpriteLength: CGFloat) -> some View {
        HStack(spacing: 2) {
            ForEach(0 ..< spriteTuples.count, id: \.self) { index -> AnyView in
                guard let image = NSImage(named: spriteTuples[index].0), let scaledImage = try? image.scaleEffect(spriteScaleMultiplier, maxLength: maxSpriteLength) else {
                        return AnyView(EmptyView())
                }
                guard let spriteCapacity = self.spriteCapacity(component: component) else {
                    return AnyView(EmptyView())
                }
                let nSprites = currentStat / spriteCapacity
                let spriteIndex = Double(spriteTuples[index].1)
                return AnyView(
                    Image(nsImage: scaledImage)
                        .opacity(
                            (nSprites - spriteIndex < 1 ? nSprites - spriteIndex >= 0 ? nSprites - spriteIndex : 0 : 1) * 0.6 + 0.4
                    )
                        .scaleEffect(nSprites - spriteIndex < 1 ? nSprites - spriteIndex >= 0 ? self.statsPulseScale : 0.8 : 1)
                        .animation(.spring())
                )
            }
        }
    }

    /// Returns a `StatsView` component in the form of a SwiftUI `View`.
    /// - Parameters:
    ///   - component: The `StatsComponent` to return.
    ///   - axis: The `Axis` of the component to return.
    /// - Returns:
    ///   - A SwiftUI `View`.
    private func component(_ component: StatsComponent, axis: Axis) -> some View {
        switch axis {
        case .horizontal:
            switch component {
            case .life:
                return AnyView(
                    spritesRow(
                        component: component,
                        currentStat: statsBar.currentLife,
                        spriteTuples: spriteTuples(component: component),
                        spriteScaleMultiplier: 1,
                        maxSpriteLength: 22
                    )
                )
            case .mana:
                return AnyView(
                    spritesRow(
                        component: component,
                        currentStat: statsBar.currentMana,
                        spriteTuples: spriteTuples(component: component),
                        spriteScaleMultiplier: 1,
                        maxSpriteLength: 22
                    )
                )
            }
        case .vertical:
            switch component {
            case .life:
                return AnyView(
                    VStack(alignment: .leading, spacing: 0) {
                        spritesRow(
                            component: component,
                            currentStat: statsBar.currentLife,
                            spriteTuples: spriteTuples(component: component, rangeHalf: .beggining),
                            spriteScaleMultiplier: 0.5,
                            maxSpriteLength: 11
                        )
                        spritesRow(
                            component: component,
                            currentStat: statsBar.currentLife,
                            spriteTuples: spriteTuples(component: component, rangeHalf: .end),
                            spriteScaleMultiplier: 0.5,
                            maxSpriteLength: 11
                        )
                    }
                )
            case .mana:
                return AnyView(
                    VStack(alignment: .leading, spacing: 0) {
                        spritesRow(
                            component: component,
                            currentStat: statsBar.currentMana,
                            spriteTuples: spriteTuples(component: component, rangeHalf: .beggining),
                            spriteScaleMultiplier: 0.5,
                            maxSpriteLength: 11
                        )
                        spritesRow(
                            component: component,
                            currentStat: statsBar.currentMana,
                            spriteTuples: spriteTuples(component: component, rangeHalf: .end),
                            spriteScaleMultiplier: 0.5,
                            maxSpriteLength: 11
                        )
                    }
                )
            }
        }
    }

    /// Returns the view to be displayed in the `body`.
    /// - Returns:
    ///   - A SwiftUI `View`.
    private func bodyView() -> some View {
        switch style.components {
        case .life:
            return AnyView(component(.life, axis: .horizontal))
        case .mana:
            return AnyView(component(.mana, axis: .horizontal))
        case .all:
            return AnyView(
                HStack(alignment: .bottom) {
                    component(.life, axis: .vertical)
                    component(.mana, axis: .vertical)
                }
            )
        }
    }

    // MARK: - Enums

    /// The axis for the components displayed inside a `StatsView.`
    enum Axis {
        case horizontal
        case vertical
    }

    /// The components which can be displayed inside a `StatsView`.
    enum ViewComponent: String {
        case life
        case mana
        case all
    }

    /// The individual components which can be displayed inside a `StatsView`.
    private enum StatsComponent {
        case life
        case mana
    }

    /// The two halfs of a range — the beggining and the end.
    private enum RangeHalf {
        case beggining
        case end
    }
}

// MARK: - Previews

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        let statsBar = StatsBar(identifier: .statsBar)
        statsBar.maxLife = 405
        statsBar.currentLife = 400
        statsBar.maxMana = 180
        statsBar.currentMana = 180
        return StatsView(statsBar: statsBar, components: .all)
    }
}
