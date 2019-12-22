//
//  AppDelegate.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 13/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import Cocoa
import SwiftUI
import AppleScriptObjC

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    let eventManager = AppEventManager()
    let touchBarController = TouchBarController()
    var keyPressBridge: KeyPressBridge?

    override init() {
        // MARK: Load AppleScript KeyPressBridge
        Bundle.main.loadAppleScriptObjectiveCScripts()
        if let keyPressBridgeClass: AnyClass = NSClassFromString("KeyPressBridge") {
            if let keyPressBridge = keyPressBridgeClass.alloc() as? KeyPressBridge {
                self.keyPressBridge = keyPressBridge
            }
        }
        super.init()
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // MARK: Setup ContentView

        let contentView = ContentView(touchBarController: touchBarController)

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
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
                client.shutdown()
            }
        }

        // MARK: Check Accessibility
        DispatchQueue.global().async {
            self.checkAccessibility()
        }
    }

    /// Checks the Accessibility settings.
    @discardableResult
    private func checkAccessibility() -> Bool {
        let checkOptPrompt = kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString
        let options = [checkOptPrompt: true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options as CFDictionary?)
        return accessEnabled
    }

}
