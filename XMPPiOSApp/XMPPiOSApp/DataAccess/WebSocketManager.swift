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
        
        webSocketTask?.receive { result in
            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    print(text)
                case .data(let data):
                    print(data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func startStream(_ stream: Stream) {
        do {
            let message = try URLSessionWebSocketTask.Message.string(StreamEncoder().encode(stream))
            webSocketTask?.send(message) { error in
                if let error = error {
                    print("WebSocket sending error: \(error)")
                } else {
                    print("WebSocket message sent !")
                }
            }
        } catch {
            print(error)
        }
    }
    
}
