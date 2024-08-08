//
//  ProfileView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: DataViewModel
    @State var notificationIsOn = false
    @State var showingLanguagePicker = false
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.dismiss) var dismiss
    let languages = ["en": "English", "ru": "Русский"]

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 40) {
                    HStack {
                        Image(uiImage: viewModel.userPhoto)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 54, height: 54)
                        VStack(alignment: .leading, spacing: 10) {
                            Text(viewModel.user.name)
                                .font(Font.custom(FontApp.bold, size: 16))
                                .foregroundStyle(.white)

                            Text(viewModel.user.email)
                                .font(Font.custom(FontApp.medium, size: 14))
                                .foregroundStyle(.white)
                        }
                        .padding(.leading, 8)
                        Spacer()

                        NavigationLink {
                            ProfileEditView(viewModel: viewModel)
                                .environmentObject(languageManager)
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
                            .stroke(Color.gray, lineWidth: 0.5)
                            .opacity(0.8)
                    }
                    .padding(.horizontal, 24)

                    VStack(spacing: 15) {
                        HStack {
                            Text("General".localized)
                                .font(Font.custom(FontApp.bold, size: 18))
                                .foregroundStyle(.white)
                            Spacer()
                        }

                        HStack {
                            ZStack {
                                Circle()
                                    .foregroundColor(.raDarkGray)
                                    .frame(width: 25, height: 25)
                                Image(systemName: "bell.fill")
                                    .foregroundStyle(.raLightGray)
                            }
                            Toggle(isOn: $notificationIsOn) {
                                Text("Notification".localized)
                                    .font(Font.custom(FontApp.medium, size: 14))
                                    .foregroundStyle(.white)
                            }
                            .toggleStyle(CustomToggle(onColor: .raLightBlue, offColor: .gray, thumbColor: .raDarkGray))
                            .onChange(of: notificationIsOn) { value in
                                if value {
                                    NotificationManager.instance.requestAutorzation()
                                    NotificationManager.instance.sheduleNotification()
                                } else {
                                    NotificationManager.instance.cancelNotification()
                                }
                            }
                        }

                        Divider().background(.gray)
                            .padding(.horizontal, 16)

                        HStack {
                            ZStack {
                                Circle()
                                    .foregroundColor(.raDarkGray)
                                    .frame(width: 25, height: 25)
                                Image(systemName: "globe")
                                    .foregroundStyle(.raLightGray)
                            }
                            Text("Language".localized)
                                .font(Font.custom(FontApp.medium, size: 14))
                                .foregroundStyle(.white)
                            Spacer()
                            Menu {
                                ForEach(languages.keys.sorted(), id: \.self) { key in
                                    Button(action: {
                                        languageManager.currentLanguage = key
                                    }) {
                                        Text(languages[key]!)
                                    }
                                }
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.raDarkGray)
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
                            .stroke(Color.gray, lineWidth: 0.5)
                            .opacity(0.8)
                    }
                    .padding(.horizontal, 24)

                    VStack(spacing: 15) {
                        HStack {
                            Text("More".localized)
                                .font(Font.custom(FontApp.bold, size: 18))
                                .foregroundStyle(.white)
                            Spacer()
                        }

                        HStack {
                            ZStack {
                                Circle()
                                    .foregroundColor(.raDarkGray)
                                    .frame(width: 25, height: 25)
                                Image(systemName: "shield.fill")
                                    .foregroundStyle(.raLightGray)
                            }

                            Text("Legal and Policies".localized)
                                .font(Font.custom(FontApp.medium, size: 14))
                                .foregroundStyle(.white)
                            Spacer()

                            NavigationLink {
                                LicenseView()
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.raDarkGray)
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
                                    .foregroundColor(.raDarkGray)
                                    .frame(width: 25, height: 25)
                                Image(systemName: "info")
                                    .foregroundStyle(.raLightGray)
                            }

                            Text("About Us".localized)
                                .font(Font.custom(FontApp.medium, size: 14))
                                .foregroundStyle(.white)
                            Spacer()

                            NavigationLink {
                                AboutView(viewModel: viewModel)
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.raDarkGray)
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
                            .stroke(Color.gray, lineWidth: 0.5)
                            .opacity(0.8)
                    }
                    .padding(.horizontal, 24)
                }
            }
            .padding(.top, 30)
            Button {
                try? FBAuthService.shared.signOut()
                viewModel.checkAuth()
                dismiss()
            } label: {
                Text("Log Out".localized)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .font(Font.custom(FontApp.medium, size: 16))
                    .background(.raLightBlue)
                    .cornerRadius(32)
            }
            .padding(.horizontal, 24)
        }
        .background(Image(.bg).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Settings".localized)
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
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

#Preview {
    ProfileView(viewModel: DataViewModel())
        .environmentObject(LanguageManager())
}
