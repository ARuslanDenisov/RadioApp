//
//  ProfileEditView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct ProfileEditView: View {
    @StateObject var viewModel: DataViewModel
    @State var nameChange: String = ""
    @State var emailChange: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                Image(uiImage: viewModel.userPhoto)
                    .resizableToFit()
                    .clipShape(Circle())
                //PhotoPicker
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        ZStack {
                            Circle()
                                .frame(width: 32)
                            Image(systemName: "pencil")
                                .foregroundStyle(.raLightBlue)
                        }
                    }
                }
            }
            .frame(width: 72, height: 72)
            Image(uiImage: viewModel.userPhoto)
            Text(viewModel.user.name)
                .font(.custom(FontApp.bold, size: 16))
                .foregroundStyle(.white)
                .padding(10)
            Text(viewModel.user.email)
                .font(.custom(FontApp.light, size: 16))
                .foregroundStyle(.white)
            VStack (spacing: 50) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke()
                        .foregroundStyle(.gray)
                    TextField(viewModel.user.name, text: $nameChange)
                        .padding(.horizontal, 15)
                        .foregroundStyle(.white)
                    HStack {
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.raDarkGray)
                                Text("Full Name")
                                    .foregroundStyle(.white)
                                    .font(.custom(FontApp.light, size: 12))
                            }
                            .frame(width: 64, height: 15)
                            
                            .padding(.horizontal, 15)
                            .offset(y:-10)
                            
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .frame(width: 323, height: 53)
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke()
                        .foregroundStyle(.gray)
                    TextField(viewModel.user.email, text: $emailChange)
                        .padding(.horizontal, 15)
                        .foregroundStyle(.white)
                    HStack {
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.raDarkGray)
                                Text("Email")
                                    .font(.custom(FontApp.light, size: 12))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 40, height: 15)
                            
                            .padding(.horizontal, 15)
                            .offset(y:-10)
                            
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .frame(width: 323, height: 53)
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundStyle(.raLightBlue)
                            .frame(width: 323, height: 53)
                        Text("Save Changes")
                            .foregroundStyle(.white)
                            .font(.custom(FontApp.medium, size: 16))
                        
                    }
                }
            }
            .padding(.vertical, 50)
            Spacer()
        }
        .background(Image(.bg).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Profile")
                    .font(.custom(FontApp.semiBold, size: 24))
                    .foregroundColor(.white)
            }
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
        .padding(.top, 30)
        .onAppear {
            self.nameChange = viewModel.user.name
            self.emailChange = viewModel.user.email
        }
    }
}

#Preview {
    NavigationView {
        ProfileEditView(viewModel: DataViewModel(user: UserModel(id: "12312312", name: "Mark", email: "soanaskn@KANkns.ru", photoUrl: "", favorites: []), stationNow: StationModel()))
    }
}
