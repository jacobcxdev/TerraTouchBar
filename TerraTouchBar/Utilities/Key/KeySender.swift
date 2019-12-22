//
//  KeyPress.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 15/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import Foundation

/// A protocol which employs a method to send a key press from a given `KeyCode`.
protocol KeyPress {
    /// Sends a key press from a given `KeyCode`.
    /// - Parameter keyCode: The `KeyCode` of the key to press.
    func send(_ keyCode: KeyCode?)
}

extension KeyPress {
    func send(_ keyCode: KeyCode?) {
        if let keyCode = keyCode {
            if let keyPressBridge = (NSApplication.shared.delegate as? AppDelegate)?.keyPressBridge {
                keyPressBridge.send(NSNumber(value: keyCode.rawValue))
            }
        }
    }
}
