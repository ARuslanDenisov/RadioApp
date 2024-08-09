//
//  PasswordResetView.swift
//  RadioApp
//
//  Created by Руслан on 05.08.2024.
//

import SwiftUI

struct PasswordResetView: View {
    //    @State private var email: String?
    @StateObject var authViewModel: AuthViewModel
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.dismiss) var dismiss
    @State var incomingURL = URL(string: "")
    @State private var sendCheck = false
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ZStack {
            Image("bgAuth")
                .resizableToFill()
                .ignoresSafeArea()
            ZStack {
                VStack(alignment: .leading) {
                    Text("Forgot \nPassword".localized)
                        .foregroundStyle(.white)
                        .font(.custom(FontApp.bold, size: 50))
                    Text("Password".localized)
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 3)
                            .foregroundStyle(.raPink)
                            .shadow(color: .raPink, radius: 5)
                            .background(.white.opacity(0.05))
                        if authViewModel.passwordHidden {
                            SecureField("Your password".localized, text: $authViewModel.password)
                                .padding(.horizontal, 10)
                                .font(.custom(FontApp.medium, size: 16))
                                .foregroundStyle(.raLightGray)
                        } else {
                            TextField("Your password".localized, text: $authViewModel.password)
                                .padding(.horizontal, 10)
                                .font(.custom(FontApp.medium, size: 16))
                                .foregroundStyle(.raLightGray)
                        }
                        
                        HStack {
                            Spacer()
                            Button {
                                authViewModel.passwordHidden.toggle()
                            } label: {
                                Image(systemName: authViewModel.passwordHidden ? "eye" : "eye.slash")
                                    .foregroundStyle(.raLightGray)
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    .frame(width: 338, height: 53)
                    
                    Text("Confirm password".localized)
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 3)
                            .foregroundStyle(.raPink)
                            .shadow(color: .raPink, radius: 5)
                            .background(.white.opacity(0.05))
                        if authViewModel.confirmPasswordHidden {
                            SecureField("Your password".localized, text: $authViewModel.confirmPassword)
                                .padding(.horizontal, 10)
                                .font(.custom(FontApp.medium, size: 16))
                                .foregroundStyle(.raLightGray)
                        } else {
                            TextField("Your password".localized, text: $authViewModel.confirmPassword)
                                .padding(.horizontal, 10)
                                .font(.custom(FontApp.medium, size: 16))
                                .foregroundStyle(.raLightGray)
                        }
                        
                        HStack {
                            Spacer()
                            Button {
                                authViewModel.confirmPasswordHidden.toggle()
                            } label: {
                                Image(systemName: authViewModel.confirmPasswordHidden ? "eye" : "eye.slash")
                                    .foregroundStyle(.raLightGray)
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    .frame(width: 338, height: 53)
                    
                    // Button Sent
                    if authViewModel.password == authViewModel.confirmPassword {
                        Button {
                            Task {
                                do {
                                    //sendCheck =
                                    try await FBAuthService.shared.updatePassword(password: password)
                                } catch {
                                    print("error")
                                }
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10 )
                                    .foregroundStyle(.raLightBlue)
                                Text("Change password".localized)
                                    .font(.custom(FontApp.medium, size: 25))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 338, height: 62)
                            .padding(.vertical, 60)
                        }
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10 )
                                .foregroundStyle(.raLightBlue)
                                .opacity(0.5)
                            Text("Change password".localized)
                                .font(.custom(FontApp.medium, size: 25))
                                .foregroundStyle(.white)
                        }
                        .frame(width: 338, height: 62)
                        .padding(.vertical, 60)
                    }
                    
                }
            }
            .blur(radius: sendCheck ? 10 : 0)
//            if sendCheck {
//                ZStack {
//                    RoundedRectangle(cornerRadius: 10)
//                        .foregroundStyle(.white)
//                    VStack {
//                        Text("Check your email".localized)
//                            .font(.custom(FontApp.regular, size: 25))
//                            .padding(.bottom, 30)
//                    }
//                    VStack {
//                        Spacer()
//                        Button {
//                            sendCheck = false
//                            dismiss()
//                        } label: {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 10)
//                                    .foregroundStyle(.raLightBlue)
//                                Text("OK".localized)
//                                    .foregroundStyle(.white)
//                            }
//                            .frame(width: 200, height: 50)
//                        }
//                        .padding()
//                    }
//                }
//                .frame(width: 350, height: 150)
//            }
            
        }
        .navigationBarBackButtonHidden(true)
        .animation(.easeInOut, value: sendCheck)
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
    PasswordResetView(authViewModel: AuthViewModel())
}
