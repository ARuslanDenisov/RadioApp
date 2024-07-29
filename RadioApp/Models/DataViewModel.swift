//
//  DataViewModel.swift
//  RadioApp
//
//  Created by Руслан on 29.07.2024.
//

import Foundation

@MainActor

class DataViewModel: ObservableObject{
    var user: UserModel = UserModel()
    var stationNow: StationModel = StationModel()
    
    init(user: UserModel, stationNow: StationModel) {
        self.user = user
        self.stationNow = stationNow
    }
    init() {
       user = UserModel()
       stationNow = StationModel()
    }
}
