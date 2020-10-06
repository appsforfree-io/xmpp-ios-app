//
//  StreamManager.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 05/10/2020.
//

import Foundation
import Combine

class StreamManager: NSObject {
    
    @Published var stream: Stream?
    
    private var cancellables: Set<AnyCancellable>
    private let wsManager: WebSocketManager
    private let environment: Environment
    
    init(wsManager: WebSocketManager, environment: Environment) {
        self.wsManager = wsManager
        self.environment = environment
        self.cancellables = []
        super.init()
        setup()
    }
    
    private func setup() {
        wsManager.$stream.sink { [unowned self] (stream) in
            self.stream = stream
        }
        .store(in: &cancellables)
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
