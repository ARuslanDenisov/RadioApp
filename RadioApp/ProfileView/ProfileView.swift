//
//  ProfileView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: DataViewModel
    @State var notificationIsOn = true
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.raDarkBlue
                .ignoresSafeArea()
            
            
            VStack {
                ScrollView {
                    VStack(spacing: 40)  {
                    HStack {
                        Image(.backgroundOnbording)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 54, height: 54)
                        VStack(alignment: .leading, spacing: 10) {
                            Text("User")
                                .font(Font.custom(FontApp.bold, size: 16))
                                .foregroundStyle(.white)
                            
                            Text("Mail")
                                .font(Font.custom(FontApp.medium, size: 14))
                                .foregroundStyle(.white)
                        }
                        .padding(.leading, 8)
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .foregroundStyle(.raLightBlue)
                        }
                        .padding(.trailing, 8)
                    }
                    .padding()
                    .cornerRadius(15)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, lineWidth: 1.0)
                            .opacity(0.8)
                    }
                    .padding(.horizontal, 24)
                    
                    VStack(spacing: 15) {
                        HStack {
                            Text("General")
                                .font(Font.custom(FontApp.bold, size: 18))
                                .foregroundStyle(.white)
                            //                                .padding(.leading,8)
                            Spacer()
                        }
                        
                        HStack {
                            ZStack {
                                Circle()
                                    .foregroundColor(.gray)
                                    .frame(width: 25, height: 25)
                                Image(systemName: "bell.fill")
                                    .foregroundStyle(.raLightGray)
                            }
                            Toggle(isOn: $notificationIsOn) {
                                Text("Notification")
                                    .font(Font.custom(FontApp.medium, size: 14))
                                    .foregroundStyle(.white)
                            }
                        }
                        
                        Divider().background(.gray)
                            .padding(.horizontal, 16)
                        
                        HStack {
                            ZStack {
                                Circle()
                                    .foregroundColor(.gray)
                                    .frame(width: 25, height: 25)
                                Image(systemName: "globe")
                                    .foregroundStyle(.raLightGray)
                            }
                            Text("Language")
                                .font(Font.custom(FontApp.medium, size: 14))
                                .foregroundStyle(.white)
                            Spacer()
                            Button {
                                
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.gray)
                                        .frame(width: 25, height: 25)
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.raLightBlue)
                                }
                            }
                        }
                    }
                    .padding()
                    .cornerRadius(15)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, lineWidth: 1.0)
                            .opacity(0.8)
                    }
                    .padding(.horizontal, 24)
                    
                    VStack(spacing: 15) {
                        HStack {
                            Text("More")
                                .font(Font.custom(FontApp.bold, size: 18))
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        
                        HStack {
                            ZStack {
                                Circle()
                                    .foregroundColor(.gray)
                                    .frame(width: 25, height: 25)
                                Image(systemName: "shield.fill")
                                    .foregroundStyle(.raLightGray)
                            }
                            
                            Text("Legal and Policies")
                                .font(Font.custom(FontApp.medium, size: 14))
                                .foregroundStyle(.white)
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.gray)
                                        .frame(width: 25, height: 25)
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.raLightBlue)
                                }
                            }
                        }
                        
                        Divider().background(.gray)
                            .padding(.horizontal, 16)
                        
                        HStack {
                            ZStack {
                                Circle()
                                    .foregroundColor(.gray)
                                    .frame(width: 25, height: 25)
                                Image(systemName: "info")
                                    .foregroundStyle(.raLightGray)
                            }
                            
                            Text("About Us")
                                .font(Font.custom(FontApp.medium, size: 14))
                                .foregroundStyle(.white)
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.gray)
                                        .frame(width: 25, height: 25)
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.raLightBlue)
                                }
                            }
                        }
                    }
                    .padding()
                    .cornerRadius(15)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, lineWidth: 1.0)
                            .opacity(0.8)
                    }
                    .padding(.horizontal, 24)
                }
            }
                Button {
                    try? FBAuthService.shared.signOut()
                    viewModel.checkAuth()
                    dismiss()
                } label: {
                    Text("Log Out")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .font(Font.custom(FontApp.medium, size: 16))
                        .background(.raLightBlue)
                        .cornerRadius(32)
                }
                .padding(.horizontal, 24)
            }
            
        }
    }
}


#Preview {
    ProfileView(viewModel: DataViewModel())
}
