import SwiftUI

struct LicenseView: View {
  @EnvironmentObject var languageManager: LanguageManager
    var body: some View {
        NavigationView {
            LicenseView()
        }
    }
}

struct LicenseView: View {
    init() {
          
          let appearance = UINavigationBarAppearance()
          appearance.configureWithOpaqueBackground()
          appearance.backgroundColor = UIColor.systemBlue
         
          UINavigationBar.appearance().standardAppearance = appearance
          UINavigationBar.appearance().scrollEdgeAppearance = appearance
      }
//    init() {
//
//           if let image = UIImage(named: "bgAuth") {
//               UINavigationBar.appearance().setBackgroundImage(image)
//           }
//       }
      
    var body: some View {
        ZStack {
            
            Image("bgAuth")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)

            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        Group {
                            Text("Terms")
                                .bold()
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(.trailing, 260)
                                .padding(.top, -200)
                            Text("""
                            Welcome to RadioApp, the mobile radio service that brings you closer to the music and shows you love. By using our app, you agree to be bound by the following terms and conditions. Please read them carefully.
                            
                            Our service allows you to listen to music, access radio shows, and interact with live broadcasts. We provide personalized content based on your listening habits and preferences.
                            """)
                            .foregroundColor(.white)
                            .padding(.top, -735)
                            Text("Privacy Policy")
                               // .bold()
                                .multilineTextAlignment(.leading)
                                .font(.title2)
                                .foregroundColor(.white)
                                
                                .padding(.top, -1050)
                                .padding(.trailing, 195)
                            Text("""
                            Your privacy is important to us. This privacy policy explains how we collect, use, and share information about you when you use our app.
                            
                            **Information Collection and Use:**
                            We collect information that you provide directly to us when you create an account, interact with our broadcasts, or contact us for support. This information may include your name, email address, and any other details you choose to provide.
                            
                            **Information Sharing:**
                            We may share your information with third-party partners who help us provide and improve our services or who use advertising or related products, which makes it possible to operate our company and provide free services to people around the world.
                            """)
                            .foregroundColor(.white)
                            .padding(.top, -1580)
                        }
                        .frame(width: 327, height: 571, alignment: .center)
                    }
                }
                .navigationTitle("Privacy Policy")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: AnotherView()) {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
}

struct AnotherView: View {
    var body: some View {
        Text("Another View Just for testing")
    }
}

struct runView_Previews: PreviewProvider {
    static var previews: some View {
        runView()
    }
}


extension UINavigationBar {
   
    func setBackgroundImage(_ image: UIImage) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()

     
        appearance.backgroundImage = image

        self.standardAppearance = appearance
        self.scrollEdgeAppearance = appearance
    }
}
