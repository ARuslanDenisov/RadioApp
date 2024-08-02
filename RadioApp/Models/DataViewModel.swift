//
//  DataViewModel.swift
//  RadioApp
//
//  Created by Руслан on 29.07.2024.
//

import Foundation
import UIKit
import SwiftUI

@MainActor

class DataViewModel: ObservableObject {
    //user
    @Published var user: UserModel = UserModel()
    //stationNow playing
    @Published var stationNow: StationModel = StationModel()
    @Published var userPhoto: UIImage = UIImage(systemName: "person")!
    @Published var showAuthView = true
    

    
    func signUp (user: UserModel) {
        Task {
            do {
                try await FBFirestoreService.shared.addNewUser(newUser: user)
                guard user.photoUrl.isEmpty else {
                    guard let url = URL(string: user.photoUrl) else { print("error with URL") ; return }
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            do {
                                try await FBStorageService.shared.uploadImage(image: image, user: user)
                            } catch {
                                
                            }
                        }
                    }
                    return
                }
            } catch {
                print("problem with sign up new user to FB")
            }
        }
    }
    
    func signIn (id: String) {
        Task {
            do {
                let userFB = try await FBFirestoreService.shared.getUser(userId: id)
                print("we have a user")
                DispatchQueue.main.async {
                    print("прокидываем юзера в модель")
                    print(userFB)
                    self.user = userFB
                }
            } catch {
                print("problem with sign in FB in mainModel")
            }
        }
    }
    
    func getUserPhoto () {
        Task {
            if try await FBStorageService.shared.checkImage(user: user) {
                do {
                    let image = try await FBStorageService.shared.downloadImage(user: user)
                    DispatchQueue.main.async {
                        self.userPhoto = image
                    }
                } catch {
                    print("problem with user picture")
                }
            } else {
                self.userPhoto = UIImage(systemName: "xmark")!
            }
        }
    }
    
    func checkAuth () {
        if let authUser = try? FBAuthService.shared.getAuthenticationUser() {
            signIn(id: authUser.uid)
            showAuthView = false
        } else {
            showAuthView = true
        }
    }
    //MARK: Inits
    
    init(user: UserModel, stationNow: StationModel) {
        self.user = user
        self.stationNow = stationNow
    }
    
    init() {
        checkAuth()
    }
}
