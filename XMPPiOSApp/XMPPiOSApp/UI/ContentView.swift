//
//  ContentView.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 04/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var engine: Engine
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear(perform: connect)
    }
    
    private func connect() {
        engine.streamManager.connect(user: "me")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
