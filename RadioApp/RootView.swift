//
//  ContentView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct RootView: View {
    @State var showSignInView = false
    
    var body: some View {
        VStack {
            //check
            if showSignInView {
                //button
                ZStack {
                    Text("")
                }
            } else {
                AuthView()
            }
            
            
            NavigationView {
                
            }
            .onAppear {
                let authUser = try? AuthenticationManager.shared.getAuthenticationUser()
                self.showSignInView = authUser == nil
            }
            .fullScreenCover(isPresented: $showSignInView, content: {
                NavigationView {
                    AuthView()
                }
            })
        }
        .padding()
    }
}

#Preview {
    RootView()
}
