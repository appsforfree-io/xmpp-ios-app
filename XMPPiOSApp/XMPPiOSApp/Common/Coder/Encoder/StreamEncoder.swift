//
//  StreamEncoder.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 06/10/2020.
//

import UIKit

class StreamEncoder: XMPPEncoder {
    
    public func encode(_ value: Stream) -> String {
        return "<stream:stream from=\'\(value.from)\' to=\'\(value.to)\'"
    }
    
}
