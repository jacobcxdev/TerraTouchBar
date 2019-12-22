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
    @Published var components: StatsView.ViewComponent

    // MARK: - Init Methods

    /// Creates an instance of `StatsViewStyle`.
    /// - Parameter components: The components which should be displayed inside a `StatsView`.
    init(components: StatsView.ViewComponent) {
        self.components = components
    }
}
