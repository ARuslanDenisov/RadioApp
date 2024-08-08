//
//  RadioAppApp.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct RadioAppApp: App {
    //Firebase import
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @StateObject var languageManager = LanguageManager()

    var body: some Scene {
        WindowGroup {
            NavigationView {
//                TestView()
                RootView()
                    .environmentObject(languageManager)
                    .onOpenURL(perform: { url in
                        PasswordResetView(incomingURL: url)
                    })
            }
        }
    }
}
