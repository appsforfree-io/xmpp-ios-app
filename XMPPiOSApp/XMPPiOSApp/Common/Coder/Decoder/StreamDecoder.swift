//
//  StreamDecoder.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 06/10/2020.
//

import UIKit

class StreamDecoder: XMPPDecoder {
    
    func decode(_ value: String) throws -> Stream {
        var to: String?
        var from: String?
        var id: String?
        var chunks = value.split(separator: " ")
        chunks.removeFirst()
        chunks.forEach {
            let attributes = $0.split(separator: "=")
            switch attributes[0] {
            case "to":
                to = attributes[1].replacingOccurrences(of: "'", with: "")
            case "from":
                from = attributes[1].replacingOccurrences(of: "'", with: "")
            case "id":
                id = attributes[1].replacingOccurrences(of: "'", with: "")
            default:
                break
            }
        }
        guard
            let t = to,
            let f = from,
            let i = id
        else { throw XMPPDecoderError.invalidFormat }
        
        return Stream(from: f, to: t, id: i)
    }

}
