//
//  ContentView.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 16/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var touchBarController: TouchBarController
    @State var statsViewComponentSelection: StatsViewStyle.ViewComponent = .all
    @State var stickyHotbar = false

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Stats to display:")
                    Picker(selection: $statsViewComponentSelection, label: EmptyView()) {
                        Text("All").tag(StatsViewStyle.ViewComponent.all)
                        Text("Life").tag(StatsViewStyle.ViewComponent.life)
                        Text("Mana").tag(StatsViewStyle.ViewComponent.mana)
                    }
                    .scaledToFit()
                }
                .fixedSize()
                .onReceive([statsViewComponentSelection].publisher) { output in
                    self.touchBarController.statsBar.style.components = output
                }
                Toggle("Sticky hotbar", isOn: $stickyHotbar)
                    .fixedSize()
                    .onReceive([stickyHotbar].publisher) { output in
                        self.touchBarController.inventoryBar.stickyHotbar = output
                }
            }
            .padding()
            Divider()
            Button("Preview") {
                DispatchQueue.global().async {
                    let client = TCPClient(
                        host: Constants.serverAddress,
                        port: Constants.serverPort,
                        handler: TCPClientHandler(message: .mockupUpdate)
                    )
                    do {
                        try client.run()
                    } catch {
                        print(error)
                    }
                    client.shutdown()
                }
            }
        }
        .padding()
        .fixedSize()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(touchBarController: TouchBarController())
    }
}
