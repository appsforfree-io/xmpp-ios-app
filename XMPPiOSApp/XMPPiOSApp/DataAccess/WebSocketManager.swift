//
//  WebSocketManager.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 04/10/2020.
//

import Foundation

class WebSocketManager: NSObject {
    
    private var webSocketTask: URLSessionWebSocketTask?
    
    func connect() {
        guard let url = URL(string: "ws://127.0.0.1:8080/xmpp-java-server/xmpp") else { return }
        let urlSession = URLSession(configuration: .default)
        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask?.resume()
    }
    
    func sendMessage() {
        let message = URLSessionWebSocketTask.Message.string("Hello Socket")
        webSocketTask?.send(message) { error in
            if let error = error {
                print("WebSocket sending error: \(error)")
            }
        }
    }
    
}
