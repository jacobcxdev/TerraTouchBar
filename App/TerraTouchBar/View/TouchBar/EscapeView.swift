//
//  EscapeView.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 15/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import SwiftUI

/// A replication of the Touch Bar escape button in the form of a SwiftUI `View`.
struct EscapeView: View {
    // MARK: - Properties

    var body: some View {
        Button(action: {
            DispatchQueue.global().async {
                let client = TCPClient(
                    host: Constants.clientAddress,
                    port: Constants.clientPort,
                    handler: TCPClientHandler(message: .escape)
                )
                do {
                    try client.run()
                } catch {
                    print(error)
                }
                client.shutdown()
            }
        }) {
            Text("esc")
                .baselineOffset(1)
                .frame(width: 48)
        }
    }
}

// MARK: - Previews

struct EscapeView_Previews: PreviewProvider {
    static var previews: some View {
        EscapeView()
    }
}
