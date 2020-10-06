//
//  UserViewModel.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 06/10/2020.
//

import SwiftUI
import Combine

class UserViewModel: NSObject, ObservableObject {
    
    @Published var username: String = ""
    @Published var isLoading: Bool = false
    
    private var cancellables: Set<AnyCancellable>
    private let engine: Engine
    
    init(engine: Engine) {
        self.engine = engine
        cancellables = []
        super.init()
        setup()
    }
    
    private func setup() {
        engine
            .streamManager
            .$stream
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (stream) in
                guard stream != nil else { return }
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func connect() {
        if !username.isEmpty {
            isLoading = true
            engine.streamManager.connect(user: username)
        }
    }
    
}
