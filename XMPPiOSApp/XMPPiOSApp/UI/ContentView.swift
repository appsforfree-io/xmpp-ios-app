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
            .padding().onAppear(perform: connect)
    }
    
    private func connect() {
        let wsManager = WebSocketManager()
        wsManager.connect()
        wsManager.sendMessage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
