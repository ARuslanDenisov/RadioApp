//
//  FavoriteView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject var viewModel: DataViewModel
    @State var activeStation: StationModel = StationModel()
    @State var bool = false
    var body: some View {
        ZStack {
            Color.raDarkBlue
                .ignoresSafeArea()
            //Header
            
            //favorites with scroll view
            VStack(alignment: .leading, spacing: 0) {
                Text("Favorites")
                    .foregroundStyle(.white)
                    .font(.custom(FontApp.regular, size: 30))
                    .padding(.top, 80)
                ScrollView {
                    ForEach(viewModel.user.favorites) { station in
//                        NavigationLink {
//                            
//                        } label: {
//                            RadioBigFavoriteElement(station: station, animationStart: true)
//                        }
                        if station.id == activeStation.id {
                            RadioBigFavoriteElement(station: station, animationStart: false)
                                .onTapGesture {
                                    activeStation = station
                                }
                        } else {
                            RadioBigFavoriteElement(station: station, animationStart: true)
                                .onTapGesture {
                                    activeStation = station
                                }
                        }
                        
                        
                           
                    }
                }
                .padding(.top, 20)
                .frame(width: 300, height: 380  )
                Spacer()
            }
            HStack {
                VStack {
//                    Spacer()
                    VolumeSliderView(value: 1.0, horizontal: false, mute: true)
                        .frame(height: 200)
                        .padding(.bottom, 180)
//                    Spacer()
                }
                .offset(x:-7)
                Spacer()
            }
            
            
        }
    }
}

#Preview {
    NavigationView {
        FavoriteView(viewModel: DataViewModel(user: UserModel(id: "", name: "Artem", email: "", photoUrl: "", favorites: [StationModel(id: "12312312", name: "Radio da4a", favicon: "", streamUrl: "", tags: "Popular", language: "English", countryCode: "RU", votes: 35),StationModel(id: "12412412", name: "Radio volga", favicon: "", streamUrl: "", tags: "Popular", language: "English", countryCode: "RU", votes: 35)
                                                                                                                         ]), stationNow: StationModel()))
    }
}


