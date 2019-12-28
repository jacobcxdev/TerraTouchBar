//
//  StatsViewStyle.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 22/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import Foundation

/// An observable object which dictates which components should be displayed inside a `StatsView`.
class StatsViewStyle: ObservableObject {
    // MARK: - Properties

    /// The components which should be displayed inside a `StatsView`.
    @Published var components: ViewComponent {
        didSet {
            UserDefaults.standard.set(components.rawValue, forKey: Constants.svcKey)
        }
    }

    // MARK: - Init Methods

    /// Creates an instance of `StatsViewStyle`.
    /// - Parameter components: The components which should be displayed inside a `StatsView`.
    init(components: ViewComponent) {
        self.components = components
    }

    /// Creates an instance of `StatsViewStyle`, using `UserDefaults.standard`.
    init() {
        var components: ViewComponent = .all
        if let svcString = UserDefaults.standard.string(forKey: Constants.svcKey), let svc = ViewComponent(rawValue: svcString) {
            components = svc
        }
        self.components = components
    }

    // MARK: - Enums

    /// The components which can be displayed inside a `StatsView`.
    enum ViewComponent: String {
        case life
        case mana
        case all
    }
}
