//
//  ContentView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct RootView: View {
    @State var showAuthView = true
    @StateObject var dataViewModel = DataViewModel()
    
    var body: some View {
        VStack {
            Text("ROOT VIEW")
            Button {
//                print(FBAuthService.shared.currentUser)
            } label: {
                Text("Privaet")
            }
            Button {
                try? FBAuthService.shared.signOut()
            } label: {
                Text("sign out!")
                    .font(.custom(FontApp.heavy, size: 50))
                    .foregroundStyle(.raPink)
            }
            
            NavigationView {
                
            }
            .onAppear {
//                let authUser = try? FBAuthService.shared.getAuthenticationUser()
//                self.showAuthView = authUser == nil
            }
            .fullScreenCover(isPresented: $showAuthView, content: {
                NavigationView {
                    AuthView(mainViewModel: dataViewModel, showAuthView: $showAuthView)
                }
            })
        }
        .padding()
    }
}

#Preview {
    RootView()
}
