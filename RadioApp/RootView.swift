//
//  ContentView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct RootView: View {
    @State var authCheck = true
    var body: some View {
        VStack {
            //check
            if authCheck {
                //button
                ZStack {
                    Text("")
                }
            } else {
                AuthView()
            }
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    RootView()
}
