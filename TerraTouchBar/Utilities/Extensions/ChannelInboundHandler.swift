//
//  ChannelInboundHandler.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 21/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import NIO

extension ChannelInboundHandler {
    func errorCaught(context: ChannelHandlerContext, error: Error) {
        print(error)
        context.close(promise: nil)
    }
}
