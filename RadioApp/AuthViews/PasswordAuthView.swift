//
//  PasswordAuthView.swift
//  RadioApp
//
//  Created by Руслан on 29.07.2024.
//

import SwiftUI

struct PasswordAuthView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var languageManager: LanguageManager
    @State var email = ""
    @State private var sendCheck = false
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
                    Text("Email".localized)
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 3)
                            .foregroundStyle(.raPink)
                            .shadow(color: .raPink, radius: 5)
                            .background(.white.opacity(0.05))
                        TextField("Your email".localized, text: $email)
//                            .padding(.horizontal, 10)
                            .font(.custom(FontApp.medium, size: 16))
                            .foregroundStyle(.raLightGray)
                            .placeholder(when: email.isEmpty) {
                              Text("Your email".localized)
                                    .foregroundStyle(.raLightGray)
                                    .font(.custom(FontApp.regular, size: 14))
                            }
                            .padding(.leading, 10)
                    }
                    .frame(width: 338, height: 53)
                    // Button Sent
                    Button {
                        Task {
                            do {
                            sendCheck = try await FBAuthService.shared.sendEmailForChange(email: email)
                            } catch {
                                print("error")
                            }
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10 )
                                .foregroundStyle(.raLightBlue)
                            Text("Sent".localized)
                                .font(.custom(FontApp.medium, size: 25))
                                .foregroundStyle(.white)
                        }
                        .frame(width: 338, height: 62)
                        .padding(.vertical, 60)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            Task {
                                try await FBAuthService.shared.resetPassword(email: email)
                            }
                            sendCheck = false
                            dismiss()
                        } label : {
                            Image(systemName: "arrow.left")
                                .resizableToFit()
                                .foregroundStyle(.white)
                        }
                    }
                    
                }
            }
            .blur(radius: sendCheck ? 10 : 0)
            if sendCheck {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                    VStack {
                        Text("Check your email".localized)
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
        .animation(.easeInOut, value: sendCheck)
    }
}

#Preview {
    NavigationView {
        PasswordAuthView()
    }
}

//RadioAppSwTeam6.page.link
