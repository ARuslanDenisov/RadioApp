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
    @State private var profileImage: UIImage?
    @State private var showImagePicker = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                if let profileImage = profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .onTapGesture {
                            self.showImagePicker = true
                        }
                }
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
        .padding(.top, 20)
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
        .sheet(isPresented: $showImagePicker, onDismiss: {
            if profileImage != nil {
                saveProfileImage()
            }
        }) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$profileImage)
                .padding(.top, 30)
                .onAppear {
                    self.nameChange = viewModel.user.name
                    self.emailChange = viewModel.user.email
                }
        }
        .onAppear {
            loadProfileImage()
        }
    }
}

extension ProfileEditView {
   
    private func loadProfileImage() {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let folderURL = documentsURL.appendingPathComponent("RadioApp")
        let fileURL = folderURL.appendingPathComponent("profileImage.jpg")
        if FileManager.default.fileExists(atPath: folderURL.path),
           let loadImage = UIImage(contentsOfFile: fileURL.path) {
            profileImage = loadImage
        }
    }
    
    private func saveProfileImage() {
        guard  let image = profileImage else { return }
        viewModel.userPhoto = profileImage ?? .appLogo
        
        // Получаем URL папки для сохранения
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let folderURL = documentsURL.appendingPathComponent("RadioApp")
        
        do {
            // Создаем папку, если она не существует
            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            
//            try await FBStorageService.shared.uploadImage(image: image, user: UserModel())
            
            // Формируем URL файла для сохранения
            let fileURL = folderURL.appendingPathComponent("profileImage.jpg")
            
            // Сохраняем изображение в файл
            if let data = image.jpegData(compressionQuality: 1.0) {
                try data.write(to: fileURL)
                print("Изображение сохранено по пути: \(fileURL.path)")
            }
        } catch {
            print("Ошибка при сохранении/чтении изображения: \(error)")
        }
    }
}

#Preview {
    NavigationView {
        ProfileEditView(viewModel: DataViewModel(user: UserModel(id: "12312312", name: "Mark", email: "soanaskn@KANkns.ru", photoUrl: "", favorites: []), stationNow: StationModel()))
    }
}
