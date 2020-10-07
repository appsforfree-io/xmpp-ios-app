//
//  MessageDecoder.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 07/10/2020.
//

import UIKit

class MessageDecoder: XMPPDecoder {
    
    func decode(_ value: String) throws -> Message {
        var to: String?
        var from: String?
        var body: String?
        let chunks = value.split(separator: ">")
        var attributeChunks = String(chunks[0]).split(separator: " ")
        attributeChunks.removeFirst()
        attributeChunks.forEach {
            let attributes = $0.split(separator: "=")
            switch attributes[0] {
            case "to":
                to = attributes[1].replacingOccurrences(of: "'", with: "")
            case "from":
                from = attributes[1].replacingOccurrences(of: "'", with: "")
            default:
                break
            }
        }
        body = String(String(chunks[2]).split(separator: "<")[0])
        guard
            let t = to,
            let f = from,
            let b = body
        else { throw XMPPDecoderError.invalidFormat }
        
        return Message(from: f, to: t, body: b)
    }

}
