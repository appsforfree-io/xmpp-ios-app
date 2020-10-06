//
//  StreamManager.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 05/10/2020.
//

import Foundation

class StreamManager: NSObject {
    
    private let wsManager: WebSocketManager
    private let environment: Environment
    
    init(wsManager: WebSocketManager, environment: Environment) {
        self.wsManager = wsManager
        self.environment = environment
    }
    
    func connect(user: String) {
        wsManager.connect()
        let stream = Stream(
            from: "\(user)@\(environment.serverName)",
            to: environment.serverName,
            id: nil
        )
        startStream(stream)
    }
    
    private func startStream(_ stream: Stream) {
        self.wsManager.send(message: .startStream(stream)) { _ in }
    }
    
}
