import SwiftUI


struct LicenseView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            
            Image("bg")
                .resizableToFill()
                .ignoresSafeArea()
            
            VStack {
                ScrollView {
                    VStack(alignment: .center, spacing: 0) {
                        
                        Text("Terms".localized)
                            .font(.custom(FontApp.bold, size: 25))
                            .foregroundColor(.white)
                            .padding(.vertical, 30)
                        
                        Text("Welcome to RadioApp, the mobile radio service that brings you closer to the music and shows you love. By using our app, you agree to be bound by the following terms and conditions. Please read them carefully.\n\nOur service allows you to listen to music, access radio shows, and interact with live broadcasts. We provide personalized content based on your listening habits and preferences.".localized)
                        .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)
                        
                        Text("Privacy Policy".localized)
                            .multilineTextAlignment(.leading)
                            .font(.custom(FontApp.bold, size: 25))
                            .foregroundColor(.white)
                            .padding(.vertical, 30)
                        Text("Your privacy is important to us. This privacy policy explains how we collect, use, and share information about you when you use our app.\n\nInformation Collection and Use:\nWe collect information that you provide directly to us when you create an account, interact with our broadcasts, or contact us for support. This information may include your name, email address, and any other details you choose to provide.\n\nInformation Sharing:\nWe may share your information with third-party partners who help us provide and improve our services or who use advertising or related products, which makes it possible to operate our company and provide free services to people around the world.".localized)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.white)
                    }
                    .padding()
                    
                }
                .padding(.top, 10)
                .frame(height: 700)
                .navigationBarTitleDisplayMode(.inline)
            }
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                    }
                    Text("Rules".localized)
                        .font(.custom(FontApp.semiBold, size: 24))
                        .foregroundColor(.white)
                        .frame(width: 100)
                        .padding(.horizontal, 80)
                    Spacer()
                    
                }
                .padding(.top, 50)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationView {
        LicenseView()
    }
}
