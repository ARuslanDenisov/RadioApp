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
    @State var index = 0
    
    
    var body: some View {
        
            NavigationView {
                ZStack {
                    VStack {
                        Spacer()
                        TabBarView(selectedTab: $index)
                    }
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
