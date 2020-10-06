//
//  StreamManager.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 05/10/2020.
//

import UIKit

class StreamManager: NSObject {
    
    let wsManager: WebSocketManager
    
    init(wsManager: WebSocketManager) {
        self.wsManager = wsManager
    }
    
    func connect() {
        wsManager.connect()
        let stream = Stream(from: "me", to: "you", id: nil)
        startStream(stream)
    }
    
    private func startStream(_ stream: Stream) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.wsManager.startStream(stream)
        }
    }
    
}
