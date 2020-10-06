//
//  WebSocketManager.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 04/10/2020.
//

import Foundation

enum WebSocketError: Error {
    case sendError
}

class WebSocketManager: NSObject {
    
    private var webSocketTask: URLSessionWebSocketTask
    
    init(environment: Environment) {
        let urlSession = URLSession(configuration: .default)
        webSocketTask = urlSession.webSocketTask(with: environment.webSocketURL)
        super.init()
    }
    
    private func setup() {
        webSocketTask.receive { result in
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
    
    func connect() {
        webSocketTask.resume()
    }
    
    func send(message: WebSocketMessage, callback: @escaping (Result<Void, WebSocketError>) -> Void) {
        webSocketTask.send(message.message) { error in
            DispatchQueue.main.async {
                if error != nil {
                    callback(.failure(.sendError))
                } else {
                    callback(.success(()))
                }
            }
        }
    }
    
}
