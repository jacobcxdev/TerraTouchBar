//
//  AppDelegate.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 13/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    // MARK: - Properties

    /// The main `NSWindow` of the application.
    var window: NSWindow!

    /// The `AppEventManager` instance which manages events for the application.
    let eventManager = AppEventManager()

    /// The `TouchBarController` instance which controls the touch bar.
    let touchBarController = TouchBarController()

    // MARK: - Instance Methods

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // MARK: Setup ContentView

        let contentView = ContentView(touchBarController: touchBarController)

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false
        )
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)

        // MARK: Setup Touch Bar

        touchBarController.showTouchBar()
        eventManager.touchBarController = touchBarController

        // MARK: Start TCPServer
        DispatchQueue.global().async {
            let server = TCPServer(host: Constants.serverAddress, port: Constants.serverPort)
            do {
                try server.run()
            } catch {
                print(error)
                server.shutdown()
            }
        }

        // MARK: Start TCPClient
        DispatchQueue.global().async {
            let client = TCPClient(
                host: Constants.clientAddress,
                port: Constants.clientPort,
                handler: TCPClientHandler(message: .playerInfo)
            )
            do {
                try client.run()
            } catch {
                print(error)
            }
            client.shutdown()
        }
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}
