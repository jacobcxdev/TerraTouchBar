//
//  ObservedViewFrameHostingView.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 22/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import SwiftUI

/// A subclass of `NSHostingView` which invokes `viewFrameDidUpdate(frame:)` on a delegate which conforms to the `ObservedViewFrameDelegate` protocol.
class ObservedViewFrameHostingView<Content>: NSHostingView<Content> where Content: View {
    // MARK: - Properties

    /// A delegate which conforms to the `ObservedViewFrameDelegate` protocol.
    weak var delegate: ObservedViewFrameDelegate?

    /// The view’s frame rectangle, which defines its position and size in its superview’s coordinate system.
    override var frame: NSRect {
        didSet {
            delegate?.viewFrameDidUpdate(frame: frame)
        }
    }
}

/// A delegate protocol which contains a method which is invoked when a given view's frame updates.
protocol ObservedViewFrameDelegate: class {
    /// A method which is invoked when a given view's frame updates.
    /// - Parameter frame: The new frame after any updates.
    func viewFrameDidUpdate(frame: CGRect)
}
