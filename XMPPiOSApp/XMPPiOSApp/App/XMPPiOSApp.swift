//
//  XMPPiOSAppApp.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 04/10/2020.
//

import SwiftUI

@main
struct XMPPiOSApp: App {
    
    @StateObject var engine: Engine = Engine()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(engine.navigationCoordinator)
                .onAppear(perform: launch)
        }
    }
    
    private func launch() {
        engine
            .navigationCoordinator
            .navigate(to: .user(viewModel: UserViewModel(engine: engine)))
    }
}
