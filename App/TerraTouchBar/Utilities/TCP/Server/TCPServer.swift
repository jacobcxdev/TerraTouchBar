//
//  PlayerInfoServer.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 14/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import NIO

/// A TCP server object which listens on a specified host address and port.
public class TCPServer {
    // MARK: - Properties

    /// The multi-threaded eventloop group.
    private let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)

    /// The host address to listen on.
    private var host: String?

    /// The port to listen on.
    private var port: Int?

    /// A bootstrap variable for creating the TCP server.
    private var serverBootstrap: ServerBootstrap {
        return ServerBootstrap(group: group)
            .serverChannelOption(ChannelOptions.backlog, value: 256)
            .serverChannelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR), value: 1)
            .childChannelInitializer { channel in
                channel.pipeline.addHandler(BackPressureHandler()).flatMap { _ in
                    channel.pipeline.addHandler(TCPServerHandler())
                }
        }
        .childChannelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR), value: 1)
        .childChannelOption(ChannelOptions.maxMessagesPerRead, value: .max)
        .childChannelOption(ChannelOptions.recvAllocator, value: AdaptiveRecvByteBufferAllocator())
    }

    // MARK: - Init Methods

    /// Creates an instance of `TCPServer`.
    /// - Parameters:
    ///   - host: The host address to listen on.
    ///   - port: The port to listen on.
    init(host: String, port: Int) {
        self.host = host
        self.port = port
    }

    // MARK: - Instance Methods

    /// Starts the TCP server.
    func run() throws {
        guard let host = host else {
            throw RuntimeError.error("Invalid host address")
        }
        guard let port = port else {
            throw RuntimeError.error("Invalid port")
        }
        do {
            let channel = try serverBootstrap.bind(host: host, port: port).wait()
            print("\(channel.localAddress!) is now open")
            try channel.closeFuture.wait()
        } catch let error {
            throw error
        }
    }

    /// Shuts down the TCP server.
    func shutdown() {
        do {
            try group.syncShutdownGracefully()
        } catch {
            print(error)
            exit(0)
        }
        print("Server closed")
    }
}
