//
//  KeyPressBridge.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 15/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import Foundation

@objc(NSObject)
/// A protocol which employs a method to send a key press from a given key code.
protocol KeyPressBridge {
    /// Sends a key press from a given key code.
    /// - Parameter keyCode: The key code, in the form of an `NSNumber`, of the key to press.
    func send(_ keyCode: NSNumber)
}
