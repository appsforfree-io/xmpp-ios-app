//
//  Encoder.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 06/10/2020.
//

import Foundation

protocol XMPPEncoder {
    
    associatedtype T
    
    func encode(_ value: T) -> String
    
}
