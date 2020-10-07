//
//  MessageEncoder.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 07/10/2020.
//

import UIKit

class MessageEncoder: XMPPEncoder {

    func encode(_ value: Message) -> String {
        return "<message from=\'\(value.from)\' to=\'\(value.to)\'><body>\(value.body)</body></message>"
    }
    
}
