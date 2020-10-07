//
//  ContentView.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 06/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var navigatorCoordinator: Navigator
    
    var body: some View {
        VStack {
            switch navigatorCoordinator.page {
            case .user(let userViewModel):
                UserView(userViewModel: userViewModel)
            case .conversations:
                Text("Conversations")
            default:
                ProgressView().progressViewStyle(CircularProgressViewStyle())
            }
        }
    }
}
