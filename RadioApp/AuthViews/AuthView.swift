//
//  AuthView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct AuthView: View {
    var signIn: Bool = true
    @State private var login = ""
    @State private var password = ""
    @State private var name = ""
    @State private var passwordHidden = true
    @State private var signInBool = false
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
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text(signInBool ? "Sign in" : "Sign up")
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
                        if !signInBool {
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
                                TextField("You email", text: $login)
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
                            TextField("You email", text: $login)
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
                            if passwordHidden {
                                SecureField("Your password", text: $password)
                                    .padding(.horizontal, 10)
                                    .font(.custom(FontApp.medium, size: 16))
                                    .foregroundStyle(.raLightGray)
                            } else {
                                TextField("Your password", text: $password)
                                    .padding(.horizontal, 10)
                                    .font(.custom(FontApp.medium, size: 16))
                                    .foregroundStyle(.raLightGray)
                            }
                            
                            HStack {
                                Spacer()
                                Button {
                                    passwordHidden.toggle()
                                } label: {
                                    Image(systemName: passwordHidden ? "eye" : "eye.slash")
                                        .foregroundStyle(.raLightGray)
                                }
                                .padding(.horizontal, 10)
                                
                            }
                        }
                        .frame(width: 338, height: 53)
                        
                    }
                    Spacer()
                }
                if signInBool {
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
                    Button {
                        //something happend
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
                            Button {
                                //something happend
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
                                signInBool.toggle()
                            } label: {
                                Text("Or \(!signInBool ? "Sign Up" : "Sign In")")
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
        .animation(.easeInOut, value: signInBool)
    }
}

#Preview {
    AuthView()
}
