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
    @StateObject var viewModel: AuthViewModel = AuthViewModel()
    @Binding var showAuthView: Bool
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
                        viewModel.email = "challenge3fb@gmail.com"
                        viewModel.password = "SwiftTeam6"
                    } label: {
                        Image(systemName: "person")
                            .frame(width: 10)
                    }
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.signInBool ? "Sign in" : "Sign up")
                            .foregroundStyle(.white)
                            .font(.custom(FontApp.bold, size: 50))
                            .padding(.vertical, 1)
                        Text ("to start play")
                            .foregroundStyle(.white)
                            .font(.custom(FontApp.light, size: 25))
                    }
                    Spacer()
                }
                .padding(.top, 35)
                HStack {
                    VStack(alignment: .leading) {
                        if !viewModel.signInBool {
                            Text("Name")
                                .foregroundStyle(.white)
                                .font(.custom(FontApp.medium, size: 16))
                                .padding(.vertical, 15)
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 3)
                                    .foregroundStyle(.raPink)
                                    .shadow(color: .raPink, radius: 5)
                                    .background(.white.opacity(0.05))
                                TextField("You name", text: $viewModel.name)
                                    .padding(.horizontal, 10)
                                    .font(.custom(FontApp.medium, size: 16))
                                    .foregroundStyle(.raLightGray)
                            }
                            .frame(width: 338, height: 53)
                        }
                        Text("Email")
                            .foregroundStyle(.white)
                            .font(.custom(FontApp.medium, size: 16))
                            .padding(.vertical, 15)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 3)
                                .foregroundStyle(.raPink)
                                .shadow(color: .raPink, radius: 5)
                                .background(.white.opacity(0.05))
                            TextField("You email", text: $viewModel.email)
                                .padding(.horizontal, 10)
                                .font(.custom(FontApp.medium, size: 16))
                                .foregroundStyle(.raLightGray)
                        }
                        .frame(width: 338, height: 53)
                        Text("Password")
                            .foregroundStyle(.white)
                            .font(.custom(FontApp.medium, size: 16))
                            .padding(.vertical, 15)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 3)
                                .foregroundStyle(.raPink)
                                .shadow(color: .raPink, radius: 5)
                                .background(.white.opacity(0.05))
                            if viewModel.passwordHidden {
                                SecureField("Your password", text: $viewModel.password)
                                    .padding(.horizontal, 10)
                                    .font(.custom(FontApp.medium, size: 16))
                                    .foregroundStyle(.raLightGray)
                            } else {
                                TextField("Your password", text: $viewModel.password)
                                    .padding(.horizontal, 10)
                                    .font(.custom(FontApp.medium, size: 16))
                                    .foregroundStyle(.raLightGray)
                            }
                            
                            HStack {
                                Spacer()
                                Button {
                                    viewModel.passwordHidden.toggle()
                                } label: {
                                    Image(systemName: viewModel.passwordHidden ? "eye" : "eye.slash")
                                        .foregroundStyle(.raLightGray)
                                }
                                .padding(.horizontal, 10)
                                
                            }
                        }
                        .frame(width: 338, height: 53)
                        
                    }
                    Spacer()
                }
                if viewModel.signInBool {
                    HStack {
                        Spacer()
                        Button {
                            //TODO: провалиться в форготпасс
                        } label: {
                            Text("Forgot Password?")
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
                        Text("Or connect with")
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
                                try await viewModel.signInGoogle()
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
                                if viewModel.signInBool {
                                    Task {
                                        let result = await !viewModel.signIn()
                                        if !result {
                                            if let authUser = try? FBAuthService.shared.getAuthenticationUser() {
                                                mainViewModel.signIn(id: authUser.uid)
                                                mainViewModel.getUserPhoto()
                                            }
                                        }
                                        DispatchQueue.main.async {
                                            showAuthView = result
                                        }
                                    }
                                } else {
                                    Task {
                                        let result = await !viewModel.signUp()
                                        print("result out")
                                        print(result)
                                        if let authUser = try? FBAuthService.shared.getAuthenticationUser() {
                                            print("authuser fetch in")
                                            print(authUser.uid)
                                            viewModel.userModel.id = authUser.uid
                                            mainViewModel.signUp(user: viewModel.userModel)
                                        }
                                        DispatchQueue.main.async {
                                            mainViewModel.user = viewModel.userModel
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
                                viewModel.signInBool.toggle()
                            } label: {
                                Text("Or \(viewModel.signInBool ? "Sign Up" : "Sign In")")
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
        .animation(.easeInOut, value: viewModel.signInBool)
    }
}

#Preview {
    AuthView(mainViewModel: DataViewModel(), showAuthView: .constant(true))
}
