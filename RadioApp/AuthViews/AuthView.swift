//
//  AuthView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthView: View {
    @StateObject var mainViewModel: DataViewModel
    @StateObject var authViewModel: AuthViewModel = AuthViewModel()
    @Binding var showAuthView: Bool
    @EnvironmentObject var languageManager: LanguageManager
    var body: some View {
        ZStack {
            Image("bgAuth")
                .resizableToFill()
                .ignoresSafeArea()
                
            VStack {
                HStack {
                    Image("appLogo")
                        .resizableToFit()
                        .frame(width: 58, height: 58)
                    Spacer()
                    Button {
                        authViewModel.email = "challenge3fb@gmail.com"
                        authViewModel.password = "SwiftTeam6"
                    } label: {
                        Image(systemName: "person")
                            .frame(width: 10)
                    }
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text(authViewModel.signInBool ? "Sign in".localized : "Sign up".localized)
                            .foregroundStyle(.white)
                            .font(.custom(FontApp.bold, size: 50))
                            .padding(.vertical, 1)
                        Text ("to start play".localized)
                            .foregroundStyle(.white)
                            .font(.custom(FontApp.light, size: 25))
                    }
                    Spacer()
                }
                .padding(.top, 35)
                HStack {
                    VStack(alignment: .leading) {
                        if !authViewModel.signInBool {
                            Text("Name".localized)
                                .foregroundStyle(.white)
                                .font(.custom(FontApp.medium, size: 16))
                                .padding(.vertical, 15)
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 3)
                                    .foregroundStyle(.raPink)
                                    .shadow(color: .raPink, radius: 5)
                                    .background(.white.opacity(0.05))
                                TextField("Your name".localized, text: $authViewModel.name)
//                                    .padding(.horizontal, 10)
                                    .font(.custom(FontApp.medium, size: 16))
                                    .foregroundStyle(.raLightGray)
                                    .placeholder(when: authViewModel.name.isEmpty) {
                                      Text("Your name".localized)
                                            .foregroundStyle(.raLightGray)
                                            .font(.custom(FontApp.regular, size: 14))
                                    }
                                    .padding(.leading, 10)
                            }
                            .frame(width: 338, height: 53)
                        }
                        Text("Email".localized)
                            .foregroundStyle(.white)
                            .font(.custom(FontApp.medium, size: 16))
                            .padding(.vertical, 15)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 3)
                                .foregroundStyle(.raPink)
                                .shadow(color: .raPink, radius: 5)
                                .background(.white.opacity(0.05))
                            TextField("Your email".localized, text: $authViewModel.email)
//                                .padding(.horizontal, 10)
                                .font(.custom(FontApp.medium, size: 16))
                                .foregroundStyle(.raLightGray)
                                .placeholder(when: authViewModel.email.isEmpty) {
                                  Text("Your email".localized)
                                        .foregroundStyle(.raLightGray)
                                        .font(.custom(FontApp.regular, size: 14))
                                }
                                .padding(.leading, 10)
                        }
                        .frame(width: 338, height: 53)
                        Text("Password".localized)
                            .foregroundStyle(.white)
                            .font(.custom(FontApp.medium, size: 16))
                            .padding(.vertical, 15)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 3)
                                .foregroundStyle(.raPink)
                                .shadow(color: .raPink, radius: 5)
                                .background(.white.opacity(0.05))
                            if authViewModel.passwordHidden {
                                SecureField("Your password".localized, text: $authViewModel.password)
//                                    .padding(.horizontal, 10)
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
                        
                    }
                    Spacer()
                }
                if authViewModel.signInBool {
                    HStack {
                        Spacer()
                        NavigationLink {
                            PasswordAuthView()
                        } label: {
                            Text("Forgot Password?".localized)
                                .foregroundStyle(.raLightGray)
                                .font(.custom(FontApp.light, size: 14))
                                .padding(.vertical, 16)
                                .padding(.trailing, 8)
                        }
                    }
                    
                    HStack {
                        Rectangle()
                            .foregroundStyle(.raLightGray)
                            .frame(width: 84, height: 1)
                        Text("Or connect with".localized)
                            .foregroundStyle(.raLightGray)
                            .font(.custom(FontApp.thin, size: 13 ))
                        Rectangle()
                            .foregroundStyle(.raLightGray)
                            .frame(width: 84, height: 1)
                    }
                    
                    //TODO: autorization google+
//                    GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
//
//                    }
                    
                    Button {
                        Task {
                            do {
                                try await authViewModel.signInGoogle()
                                if let authUser = try? FBAuthService.shared.getAuthenticationUser() {
                                    mainViewModel.signIn(id: authUser.uid)
                                    mainViewModel.getUserPhoto()
                                    DispatchQueue.main.async {
                                        showAuthView = false
                                    }
                                }
                            } catch {
                                print(error)
                            }
                        }
                    } label: {
                        Image("googleLogo")
                            .resizableToFit()
                            .frame(width: 40)
                    }
                    
                }
                VStack {
                    Spacer()
                    HStack {
                        VStack (alignment: .leading) {
                            // MARK: Sing in Sign up button
                            Button {
                                if authViewModel.signInBool {
                                    Task {
                                        let result = await !authViewModel.signIn()
                                        if !result {
                                            if let authUser = try? FBAuthService.shared.getAuthenticationUser() {
                                                mainViewModel.signIn(id: authUser.uid)
                                                
                                            }
                                        }
                                        DispatchQueue.main.async {
                                            showAuthView = result
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ){
                                            mainViewModel.getUserPhoto()
                                        }
                                    }
                                } else {
                                    Task {
                                        let result = await !authViewModel.signUp()
                                        print("result out")
                                        print(result)
                                        if let authUser = try? FBAuthService.shared.getAuthenticationUser() {
                                            print("authuser fetch in")
                                            print(authUser.uid)
                                            authViewModel.userModel.id = authUser.uid
                                            mainViewModel.signUp(user: authViewModel.userModel)
                                        }
                                        DispatchQueue.main.async {
                                            mainViewModel.user = authViewModel.userModel
                                            showAuthView = result
                                        }
                                    }
                                    
                                }
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10 )
                                        .foregroundStyle(.raLightBlue)
                                    Image (systemName: "arrow.right")
                                        .resizableToFit()
                                        .foregroundStyle(.white)
                                        .frame(width: 36)
                                }
                                .frame(width: 153, height: 62)
                            }
                            Button {
                                authViewModel.signInBool.toggle()
                            } label: {
                              Text(String(format: "Or %@".localized, authViewModel.signInBool ? "Sign Up".localized : "Sign In".localized))
                                    .padding(.vertical, 8)
                                    .foregroundStyle(.raLightGray)
                                    .font(.custom(FontApp.medium, size: 16))
                            }
                        }
                        .padding(.bottom, 33)
                        Spacer()
                    }
                    Spacer()
                }
                
            }
            .padding(38)
            
        }
        .animation(.easeInOut, value: authViewModel.signInBool)
    }
}

#Preview {
    AuthView(mainViewModel: DataViewModel(), showAuthView: .constant(true))
}
