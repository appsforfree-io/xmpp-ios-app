//
//  WebSocketManager.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 04/10/2020.
//

import Foundation
import Combine

enum WebSocketError: Error {
    case sendError
    case messageError
}

class WebSocketManager: NSObject {
    
    @Published var stream: Stream?
    
    private var webSocketTask: URLSessionWebSocketTask
    
    init(environment: Environment) {
        let urlSession = URLSession(configuration: .default)
        webSocketTask = urlSession.webSocketTask(with: environment.webSocketURL)
        super.init()
        setup()
    }
    
    private func setup() {
        webSocketTask.receive { [unowned self] result in
            switch result {
            case .success(let message):
                self.handleMessage(message)
            case .failure(let error):
                self.handleMessageError(error)
            }
        }
    }
    
    private func handleMessage(_ message: URLSessionWebSocketTask.Message) {
        switch message {
        case .string(let text):
            decode(message: text)
        default:
            break
        }
    }
    
    private func decode(message: String) {
        do {
            if message.starts(with: "<stream:stream") {
                stream = try StreamDecoder().decode(message)
            }
        } catch {
            
        }
    }
    
    private func handleMessageError(_ error: Error) {
        
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
