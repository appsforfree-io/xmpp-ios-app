//
//  UserViewModel.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 06/10/2020.
//

import SwiftUI

class UserViewModel: NSObject, ObservableObject {
    
    @Published var username: String = ""
    @Published var isLoading: Bool = false
    
    private let engine: Engine
    
    init(engine: Engine) {
        self.engine = engine
    }
    
    func connect() {
        if !username.isEmpty {
            isLoading = true
            engine.streamManager.connect(user: username)
        }
    }
    
}
