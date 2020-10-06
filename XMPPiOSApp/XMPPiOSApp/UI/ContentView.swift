//
//  ContentView.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 04/10/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear(perform: connect)
    }
    
    private func connect() {
        let streamManager = StreamManager(wsManager: WebSocketManager())
        streamManager.connect()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
