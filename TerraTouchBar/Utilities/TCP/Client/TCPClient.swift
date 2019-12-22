//
//  PlayerInfoClient.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 18/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import NIO

/// A TCP client object which sends data on a specified host address and port.
public class TCPClient {
    // MARK: - Properties

    /// The multi-threaded eventloop group.
    private let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)

    /// The host address to send data on.
    private var host: String?

    /// The port to send data on.
    private var port: Int?

    /// A `ChannelHandler` to handle I/O events for a `Channel`.
    private var handler: ChannelHandler

    /// A bootstrap variable for creating the TCP client.
    private var bootstrap: ClientBootstrap {
        return ClientBootstrap(group: group)
            .channelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR), value: 1)
            .channelInitializer { channel in
                channel.pipeline.addHandler(self.handler)
        }
    }

    // MARK: - Init Methods

    /// Creates an instance of `TCPClient`.
    /// - Parameters:
    ///   - host: The host address to send data on.
    ///   - port: The port to send data on.
    ///   - handler: A `ChannelHandler` to handle I/O events for a `Channel`.
    init(host: String, port: Int, handler: ChannelHandler) {
        self.host = host
        self.port = port
        self.handler = handler
    }

    // MARK: - Instance Methods

    /// Starts the TCP client.
    func run() throws {
        guard let host = host else {
            throw RuntimeError.error("Invalid host address")
        }
        guard let port = port else {
            throw RuntimeError.error("Invalid port")
        }
        do {
            let channel = try bootstrap.connect(host: host, port: port).wait()
            try channel.closeFuture.wait()
        } catch let error {
            throw error
        }
    }

    /// Shuts down the TCP client.
    func shutdown() {
        do {
            try group.syncShutdownGracefully()
        } catch {
            print(error)
            exit(0)
        }
        print("Client connection closed")
    }
}
