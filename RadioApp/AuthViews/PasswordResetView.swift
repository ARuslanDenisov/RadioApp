//
//  PasswordResetView.swift
//  RadioApp
//
//  Created by Руслан on 05.08.2024.
//

import SwiftUI

struct PasswordResetView: View {
    @State private var email: String?
    @State var incomingURL = URL(string: "")
    var body: some View {
        VStack {
            Text("Hello, World!")
            if let email {
                Text(email)
            }
        }
        .onOpenURL { incomingURL in
                    print("App was opened via URL: \(incomingURL)")
                    handleIncomingURL(incomingURL)
                }
            
        
    }
    private func handleIncomingURL(_ url: URL) {
            guard url.scheme == "RadioApp" else {
                return
            }
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                print("Invalid URL")
                return
            }

            guard let action = components.host, action == "change-email" else {
                print("Unknown URL, we can't handle this one!")
                return
            }

        guard let email = components.queryItems?.first(where: { $0.name == "email" })?.value else {
                print("Recipe name not found")
                return
            }

        self.email = email
        }
}

#Preview {
    PasswordResetView()
}
