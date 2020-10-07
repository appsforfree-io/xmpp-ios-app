//
//  Engine.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 06/10/2020.
//

import UIKit

class Engine: NSObject, ObservableObject {
    
    private let websocketManager: WebSocketManager
    
    let streamManager: StreamManager
    
    let navigationCoordinator: Navigator
    
    let environment: Environment
    
    override init() {
        guard let environment = Environment() else { fatalError() }
        self.environment = environment
        websocketManager = WebSocketManager(environment: environment)
        streamManager = StreamManager(wsManager: websocketManager, environment: environment)
        navigationCoordinator = Navigator()
        
        super.init()
    }
    
}
