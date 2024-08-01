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

class DataViewModel: ObservableObject{
    @State var user: UserModel = UserModel()
    var stationNow: StationModel = StationModel()
    var userPhoto: UIImage = UIImage(systemName: "person")!
    
    init(user: UserModel, stationNow: StationModel) {
        self.user = user
        self.stationNow = stationNow
    }
    init() {
        user = UserModel()
        stationNow = StationModel()
    }
    
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
    
    //    func signIn (id: String) async throws -> UserModel {
    //            do {
    //                let user = try await FBFirestoreService.shared.getUser(userId: id)
    //                return user
    //            } catch {
    //                print("problem with sign in FB in mainModel")
    //                return UserModel()
    //            }
    //    }
    //
    func signIn (id: String) {
        Task {
            do {
                let user = try await FBFirestoreService.shared.getUser(userId: id)
                DispatchQueue.main.async {
                    self.user = user
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
                self.userPhoto = UIImage(systemName: "person")!
            }
        }
    }
}
