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
    @State private var statsViewComponentSelection: StatsView.ViewComponent = .all

    var body: some View {
        VStack {
            HStack {
                Text("Stats to display:")
                Picker(selection: $statsViewComponentSelection, label: EmptyView()) {
                    Text("All").tag(StatsView.ViewComponent.all)
                    Text("Life").tag(StatsView.ViewComponent.life)
                    Text("Mana").tag(StatsView.ViewComponent.mana)
                }
                .scaledToFit()
            }
            .padding()
            .fixedSize()
            .onReceive([statsViewComponentSelection].publisher) { output in
                self.touchBarController.statsBar.setStatsViewComponents(components: output)
            }
            Divider()
            Button("Send mockup update") {
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
