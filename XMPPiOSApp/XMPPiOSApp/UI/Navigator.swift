//
//  NavigationCoordinator.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 06/10/2020.
//

import Foundation
import Combine

class Navigator: NSObject, ObservableObject {
    
    enum Page {
        case user(viewModel: UserViewModel)
        case conversations
        
        var title: String {
            switch self {
            case .user:
                return "User"
            case .conversations:
                return "Conversations"
            }
        }
    }
    
    @Published private (set) var page: Page?
    @Published var isConversationsActive: Bool = false
    
    func navigate(to page: Page) {
        switch page {
        case .conversations:
            isConversationsActive = true
        default:
            self.page = page
        }
    }
    
}
