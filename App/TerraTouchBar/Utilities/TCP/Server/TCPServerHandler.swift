//
//  PlayerInfoServerHandler.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 14/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import NIO
import SwiftyJSON

/// An object which handles inbound I/O events for a `Channel`.
class TCPServerHandler: ChannelInboundHandler {
    // MARK: - Typealiases

    public typealias InboundIn = ByteBuffer
    public typealias OutboundOut = ByteBuffer

    // MARK: - Properties

    /// A string buffer for creating the completed received string via a `Channel`.
    private var receivedString = ""

    // MARK: - Instance Methods

    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let read = unwrapInboundIn(data)
        receivedString += read.getString(at: 0, length: read.readableBytesView.count) ?? ""
        if receivedString.contains("<EOF>") {
            DispatchQueue.main.async {
                if let appDelegate = (NSApplication.shared.delegate as? AppDelegate) {
                    appDelegate.eventManager.receivedUpdate(
                        json: JSON(parseJSON: self.receivedString.replacingOccurrences(of: "<EOF>", with: ""))
                    )
                }
            }
        }
    }

    func channelReadComplete(context: ChannelHandlerContext) {
        context.flush()
    }
}
