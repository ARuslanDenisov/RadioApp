//
//  FavoriteView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject var viewModel: DataViewModel
    @EnvironmentObject var languageManager: LanguageManager
    @State var bool = false
  
    var body: some View {
        ZStack {
            Color.raDarkBlue
                .ignoresSafeArea()
            //Header
            
            //favorites with scroll view
            VStack(alignment: .leading, spacing: 0) {
                Text("Favorites".localized)
                    .foregroundStyle(.white)
                    .font(.custom(FontApp.regular, size: 30))
                    .padding(.top, 80)
                ScrollView {
                    ForEach(viewModel.user.favorites) { station in
                        ZStack {
                            if station.id != viewModel.stationNow.id {
                                RadioBigFavoriteElement(station: station, animationStart: false)
                                    .onTapGesture {
                                        viewModel.stationNow = station
                                        viewModel.radioPlayer.loadPlayer(from: viewModel.stationNow)
                                        viewModel.radioPlayer.playMusic()
                                        viewModel.play = true
                                    }
                                    
                            } else {
                                RadioBigFavoriteElement(station: station, animationStart: true)
                                    .onTapGesture {
                                        viewModel.stationNow = station
                                        viewModel.radioPlayer.loadPlayer(from: viewModel.stationNow)
                                        viewModel.radioPlayer.playMusic()
                                        viewModel.play = true
                                    }
                                    .onLongPressGesture(minimumDuration: 1.0) {
                                        viewModel.showDetailView = true
                                    }
                            }
                            HStack {
                                Spacer()
                                VStack {
                                    Image(systemName: "xmark")
                                        .resizableToFit()
                                        .frame(width: 15)
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 13)
                                        .padding(.horizontal, 17)
                                        .onTapGesture {
                                            viewModel.toFavorite(station: station)
                                        }
                                    Spacer()
                                }
                            }
                            .frame(width: 300, height: 119)
                        }
                        
                        
                           
                    }
                    Spacer(minLength: 100)
                        .frame(height: 100)
                }
                .padding(.top, 20)
                .frame(width: 300, height: 550  )
                Spacer()
            }
            HStack {
                VStack {
//                    Spacer()
                    VolumeSliderView(horizontal: false, mute: true)
                        .frame(height: 200)
                        .padding(.bottom, 180)
//                    Spacer()
                }
                .offset(x:-7)
                Spacer()
            }
            
            
        }
        .animation(.easeInOut, value: viewModel.user.favorites.count)
    }
}

#Preview {
    NavigationView {
        FavoriteView(viewModel: DataViewModel(user: UserModel(id: "", name: "Artem", email: "", photoUrl: "", favorites: [StationModel(id: "12312312", name: "Radio da4a", favicon: "", streamUrl: "", tags: "Popular", language: "English", countryCode: "RU", votes: 35),StationModel(id: "12412412", name: "Radio volga", favicon: "", streamUrl: "", tags: "Popular", language: "English", countryCode: "RU", votes: 35)
                                                                                                                         ]), stationNow: StationModel()))
    }
}


