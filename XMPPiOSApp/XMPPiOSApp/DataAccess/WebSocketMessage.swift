//
//  WebSocketMessage.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 06/10/2020.
//

import UIKit

enum WebSocketMessage {
    case startStream(_ stream: Stream)
    
    var message: URLSessionWebSocketTask.Message {
        switch self {
        case .startStream(let stream):
            return URLSessionWebSocketTask.Message.string(StreamEncoder().encode(stream))
        }
    }
    
}
