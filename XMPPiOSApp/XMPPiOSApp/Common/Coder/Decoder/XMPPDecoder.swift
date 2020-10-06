//
//  XMPPDecoder.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 06/10/2020.
//

import UIKit

enum XMPPDecoderError: Error {
    case invalidFormat
}

protocol XMPPDecoder {
    
    associatedtype T
    
    func decode(_ value: String) throws -> T
    
}
