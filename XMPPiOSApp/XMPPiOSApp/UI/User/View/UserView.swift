//
//  UserView.swift
//  XMPPiOSApp
//
//  Created by Jérémy Oddos on 06/10/2020.
//

import SwiftUI

struct UserView: View {
    
    @EnvironmentObject var navigationCoordinator: Navigator
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 100) {
                if userViewModel.isLoading {
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                } else {
                    TextField("Username", text: $userViewModel.username)
                    NavigationLink(
                        destination: Text("Destination"),
                        isActive: $navigationCoordinator.isConversationsActive,
                        label: {
                            Button("Enter Chat") {
                                userViewModel.connect()
                            }
                        })
                }
            }
            .padding()
            .navigationBarTitle("User")
        }
    }
    
    
}
