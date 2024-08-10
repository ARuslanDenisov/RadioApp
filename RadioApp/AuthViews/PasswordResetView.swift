//
//  PasswordResetView.swift
//  RadioApp
//
//  Created by Руслан on 05.08.2024.
//

import SwiftUI

struct PasswordResetView: View {
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
                    Text("Change \nPassword".localized)
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
//                                .padding(.horizontal, 10)
                                .font(.custom(FontApp.medium, size: 16))
                                .foregroundStyle(.raLightGray)
                                .placeholder(when: authViewModel.password.isEmpty) {
                                  Text("Your password".localized)
                                        .foregroundStyle(.raLightGray)
                                        .font(.custom(FontApp.regular, size: 14))
                                }
                                .padding(.leading, 10)
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
//                                .padding(.horizontal, 10)
                                .font(.custom(FontApp.medium, size: 16))
                                .foregroundStyle(.raLightGray)
                                .placeholder(when: authViewModel.confirmPassword.isEmpty) {
                                  Text("Your password".localized)
                                        .foregroundStyle(.raLightGray)
                                        .font(.custom(FontApp.regular, size: 14))
                                }
                                .padding(.leading, 10)
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
                    if authViewModel.password == authViewModel.confirmPassword && authViewModel.password.count >= 6 {
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
                                Text("Change Password".localized)
                                    .font(.custom(FontApp.medium, size: 25))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 338, height: 62)
                            .padding(.vertical, 60)
                        }
                        .disabled(authViewModel.password != authViewModel.confirmPassword)
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
            
            if sendCheck {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                    VStack {
                        Text("Password changed".localized)
                            .font(.custom(FontApp.regular, size: 25))
                            .padding(.bottom, 30)
                    }
                    VStack {
                        Spacer()
                        Button {
                            sendCheck = false
                            dismiss()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.raLightBlue)
                                Text("OK".localized)
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 200, height: 50)
                        }
                        .padding()
                    }
                }
                .frame(width: 350, height: 150)
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label : {
                    Image(systemName: "arrow.left")
                        .resizableToFit()
                        .foregroundStyle(.white)
                }
            }
        }
        .animation(.easeInOut, value: sendCheck)
         
    }
}

#Preview {
    PasswordResetView(authViewModel: AuthViewModel())
}
