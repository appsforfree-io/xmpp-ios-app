//
//  XMPPiOSAppApp.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 04/10/2020.
//

import SwiftUI

@main
struct XMPPiOSAppApp: App {
    
    @StateObject var engine: Engine = Engine()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(engine)
        }
    }
}
