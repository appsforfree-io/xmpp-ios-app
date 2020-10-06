//
//  Environment.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 06/10/2020.
//

import UIKit

struct Environment {
    
    let webSocketURL: URL
    let serverName: String
    
    init?() {
        guard let webSocketURL = URL(string: "ws://127.0.0.1:8080/xmpp-java-server/xmpp") else { return nil }
        self.webSocketURL = webSocketURL
        self.serverName = "xmpp.appsforfree.io"
    }
    
}
