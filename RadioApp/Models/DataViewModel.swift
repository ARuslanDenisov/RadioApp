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
    @Published var tabBarIndex = 0
    //user
    @Published var user: UserModel = UserModel()
    //stationNow playing
    @Published var stationNow: StationModel = StationModel()
    @Published var userPhoto: UIImage = UIImage(systemName: "person")!
    @Published var showAuthView = true
    @Published var play: Bool = false
    @Published var popular: [StationModel] = []
    @Published var allStation : [StationModel] = []
    @Published var indexRadio = 0
    @Published var radioPlayer = RadioPlayer.shared
    @Published var showDetailView = false
    @Published var showTabBar = true
    @Published var showLoading = true
    @AppStorage("onboarding") var showOnboarding = true
    
    @Published var scaleAmount: CGFloat = 1
    @Published var opacityAmount: CGFloat = 1
    
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
                do {
                    let image = try await FBStorageService.shared.downloadImage(user: user)
                    DispatchQueue.main.async {
                        self.userPhoto = image
                    }
                } catch {
                    print("problem with user picture")
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
    
    func nextStation () {
        print("next station")
        print(indexRadio)
        print(popular.count - 1)
        switch tabBarIndex {
        case 0: stationNow = popular[indexRadio == (popular.count - 1) ? indexRadio : indexRadio + 1 ] ; indexRadio += 1
        case 1: stationNow = user.favorites[indexRadio == (user.favorites.count - 1) ? indexRadio : indexRadio + 1] ; indexRadio += 1
        case 2: stationNow = allStation[indexRadio == (allStation.count - 1) ? indexRadio : indexRadio + 1] ; indexRadio += 1
        default: ()
        }
    }
    func prevStation () {
        switch tabBarIndex {
        case 0: stationNow = popular[indexRadio == 0 ? 0 : indexRadio - 1 ] ; indexRadio -= indexRadio == 0 ? 0 : 1
        case 1: stationNow = user.favorites[indexRadio == 0 ? indexRadio : indexRadio - 1] ; indexRadio -= indexRadio == 0 ? 0 : 1
        case 2: stationNow = allStation[indexRadio == 0 ? indexRadio : indexRadio - 1] ; indexRadio -= indexRadio == 0 ? 0 : 1
        default: ()
        }
    }
    
    func checkFavorite(station: StationModel) -> Bool {
        guard user.favorites.count != 0 else { return false }
        return user.favorites.contains { stationIn in
            stationIn.id == station.id
        }
    }
    
    func toFavorite(station: StationModel) {
        if checkFavorite(station: station) {
            user.favorites = user.favorites.filter({ stationModel in
                stationModel.id != station.id
            })
        } else {
            user.favorites.append(station)
        }
        
    }
    
    func changeName(name: String ) {
        Task {
            let updateUser = try await FBAuthService.shared.changeName(user:user, name: name)
            DispatchQueue.main.async {
                self.user = updateUser
            }
        }
    }
    
    func changeEmail(email: String) {
        Task {
            try await FBAuthService.shared.changeEmail(email: email)
        }
    }
    
    //MARK: Inits
    init(user: UserModel, stationNow: StationModel) {
        self.user = user
        self.stationNow = stationNow
    }
    
    init() {
        checkAuth()
        Task {
            do {
                popular = try await NetworkServiceAA.shared.getPopularStations(numberLimit: 18)
                allStation = try await NetworkServiceAA.shared.getAllStations(numberLimit: 15)
            } catch {
                print("error with getting all data")
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.getUserPhoto()
        }
        
    }
}
