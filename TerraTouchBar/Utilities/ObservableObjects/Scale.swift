//
//  Scale.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 21/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import Foundation

/// An observable object storing a multiplier and maximum length.
class Scale: ObservableObject {
    // MARK: - Properties

    /// The scale multiplier.
    @Published var multiplier: CGFloat = 1

    /// The maximum length (width or height, whichever is greater).
    @Published var maxLength: CGFloat = .infinity

    // MARK: - Init Methods

    /// Creates an instance of `Scale`.
    init() {

    }

    /// Creates an instance of `Scale`, with a given multiplier and maximum length.
    /// - Parameters:
    ///   - multiplier: The scale multiplier.
    ///   - maxLength: The maximum length (width or height, whichever is greater).
    init(multiplier: CGFloat, maxLength: CGFloat) {
        self.multiplier = multiplier
        self.maxLength = maxLength
    }
}
