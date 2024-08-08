//
//  AllStationView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct AllStationView: View {

    @StateObject var viewModel: DataViewModel
    @EnvironmentObject var languageManager: LanguageManager
    @State var headerText = ["Popular".localized, "Favorites".localized, "All Stations".localized]
    @State var searchRadio: String = ""
    @State var searchActive = false
    @State var tabIndex: Int = 0
    @State var searchArray: [StationModel] = []
    @State var searchSet = false
    @State var searchType: SearchType = .country
    @State var searchTag = ""
    
    var body: some View {
        ZStack {
            
            Color.raDarkBlue
                .ignoresSafeArea()
            
            VStack {
                HStack {
                  Text( searchActive ? headerText[tabIndex] : "All Stations".localized )
                        .foregroundStyle(.white)
                        .font(.custom(FontApp.regular, size: 30))
                        .padding(.top, 80)
                        .padding(.leading, searchActive ? 130 : 50)
                    Spacer()
                }
                
                HStack {
                    ZStack {
                        SearchField(searchRadio: $searchRadio)
                            .frame(width: searchActive ? 290 : 380)
                            .padding(.horizontal, 10)
                            .padding(.leading, searchActive ? 80 : 0)
                            .onTapGesture {
                                searchActive = true
                                viewModel.showTabBar = false
                            }
                        HStack {
                            Spacer()
                            Button {
                                if tabIndex == 0 {
                                    Task {
                                        let array = try await NetworkServiceAA.shared.searchStations(name: searchRadio, numberLimit: 12)
                                        DispatchQueue.main.async {
                                            searchArray = array
                                        }
                                    }
                                }
                                if tabIndex == 1 {
                                    searchArray = searchArray.filter({ station in
                                        station.name.lowercased() == searchRadio.lowercased()
                                    })
                                }
                                if tabIndex == 2 {
                                    Task {
                                        let array = try await NetworkServiceAA.shared.searchStationWithTag(search: searchRadio, setup: searchType, value: searchTag, numberLimit: 18)
                                        DispatchQueue.main.async {
                                            searchArray = array
                                        }
                                    }
                                }
                            } label: {
                                Image(systemName: "chevron.right")
                                    .padding(9)
                                    .foregroundStyle(.raLightBlue)
                                    .background(.black)
                                    .clipShape(Circle())
                                    .padding(.horizontal, 10)
                                    
                            }
                        }
                        .frame(width: 380)
                    }
                }
                if !searchActive {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ForEach(viewModel.allStation.indices, id: \.self) { index in
                                ZStack {
                                    if viewModel.stationNow.id == viewModel.allStation[index].id {
                                        RadioBigAllStationElement(station: viewModel.allStation[index], playingNow: true)
                                            .shadow(color: .raPink.opacity(0.7), radius: 10)
                                            .onTapGesture {
                                                viewModel.stationNow = viewModel.allStation[index]
                                                viewModel.indexRadio = index
                                                viewModel.radioPlayer.playMusicWithURL(viewModel.stationNow)
                                                viewModel.play = true
                                            }
                                            .onLongPressGesture(minimumDuration: 1.0) {
                                                viewModel.showDetailView = true
                                            }
                                    } else {
                                        RadioBigAllStationElement(station: viewModel.allStation[index], playingNow: false)
                                            .onTapGesture {
                                                viewModel.stationNow = viewModel.allStation[index]
                                                viewModel.indexRadio = index
                                                viewModel.radioPlayer.playMusicWithURL(viewModel.stationNow)
                                                viewModel.play = true
                                            }
                                    }
                                    HStack {
                                        Spacer()
                                        VStack {
                                            Image(systemName: viewModel.checkFavorite(station: viewModel.popular[index]) ? "heart.fill" : "heart")
                                                .resizableToFit()
                                                .frame(width: 13)
                                                .foregroundStyle(.white)
                                                .padding(.horizontal, 14)
                                                .padding(.vertical, 14)
                                                .onTapGesture {
                                                    
                                                }
                                            Spacer()
                                        }
                                    }
                                    .frame(width: 300, height: 129)
                                }
                                .frame(height: 124)
                                
                            }
                        }
                        .animation(.easeInOut, value: viewModel.stationNow.id)
                        
                    }
                    
                }
                //                .frame(width: 300, height: 380)
                Spacer()
                if searchActive {
                    HStack {
                        VStack {
                            if tabIndex == 0 {
                                HStack {
                                    Spacer()
                                    VStack {
                                        ScrollView {
                                            ForEach(searchArray, id:\.id) { station in
                                                if viewModel.stationNow.id == station.id {
                                                    RadioBigAllStationElement(station: station, playingNow: true)
                                                        .onTapGesture {
                                                            viewModel.stationNow = station
                                                            viewModel.radioPlayer.loadPlayer(from: viewModel.stationNow)
                                                            viewModel.radioPlayer.playMusic()
                                                            viewModel.play = true
                                                        }
                                                        .padding(10)
                                                } else {
                                                    RadioBigAllStationElement(station: station, playingNow: false)
                                                        .onTapGesture {
                                                            viewModel.stationNow = station
                                                            viewModel.radioPlayer.loadPlayer(from: viewModel.stationNow)
                                                            viewModel.radioPlayer.playMusic()
                                                            viewModel.play = true
                                                        }
                                                }
                                            }
                                        }
                                        .frame(width: 350, height: 390)
                                        .onAppear {
                                            Task {
                                                let array = try await NetworkServiceAA.shared.searchStations(name: searchRadio, numberLimit: 12)
                                                DispatchQueue.main.async {
                                                    searchArray = array
                                                }
                                            }
                                        }
                                        Spacer ()
                                    }
                                }
                                .onDisappear {
                                    searchArray = []
                                    searchRadio = ""
                                }
                            }
                            //favorites
                            if tabIndex == 1 {
                                HStack {
                                    Spacer()
                                    VStack {
                                        ScrollView {
                                            ForEach(viewModel.user.favorites, id: \.id ) { station in
                                                if viewModel.stationNow.id == station.id {
                                                    RadioBigAllStationElement(station: station, playingNow: true)
                                                        .onTapGesture {
                                                            viewModel.stationNow = station
                                                            viewModel.radioPlayer.loadPlayer(from: viewModel.stationNow)
                                                            viewModel.radioPlayer.playMusic()
                                                            viewModel.play = true
                                                        }
                                                        .padding(10)
                                                } else {
                                                    RadioBigAllStationElement(station: station, playingNow: false)
                                                        .onTapGesture {
                                                            viewModel.stationNow = station
                                                            viewModel.radioPlayer.loadPlayer(from: viewModel.stationNow)
                                                            viewModel.radioPlayer.playMusic()
                                                            viewModel.play = true
                                                        }
                                                }
                                            }
                                        }
                                        .frame(width: 350, height: 390)
                                        .onAppear {
                                            searchArray = viewModel.user.favorites
                                        }
                                        Spacer()
                                    }
                                }
                            }
                            //All Stations
                            if tabIndex == 2 {
                                ZStack {
                                    if !searchSet {
                                        VStack {
                                            HStack {
                                                Spacer()
                                                SearchView(searchSetup: $searchType, searchTag: $searchTag, searchSet: $searchSet, closure: { print("1") })
                                                    .onDisappear {
                                                        Task {
                                                            let stations = try await NetworkServiceAA.shared.getStationsByTag(setup:searchType ,value: searchTag ,numberLimit: 20)
                                                            DispatchQueue.main.async {
                                                                searchArray = stations
                                                            }
                                                        }
                                                    }
                                            }
                                            Spacer()
                                        }
                                    } else {
                                        HStack {
                                            Spacer()
                                            VStack {
                                                ScrollView {
                                                    ForEach (searchArray, id: \.id) { station in
                                                        if viewModel.stationNow.id == station.id {
                                                            RadioBigAllStationElement(station: station, playingNow: true)
                                                                .onTapGesture {
                                                                    viewModel.stationNow = station
                                                                    viewModel.radioPlayer.loadPlayer(from: viewModel.stationNow)
                                                                    viewModel.radioPlayer.playMusic()
                                                                    viewModel.play = true
                                                                }
                                                                .padding(10)
                                                        } else {
                                                            RadioBigAllStationElement(station: station, playingNow: false)
                                                                .onTapGesture {
                                                                    viewModel.stationNow = station
                                                                    viewModel.radioPlayer.loadPlayer(from: viewModel.stationNow)
                                                                    viewModel.radioPlayer.playMusic()
                                                                    viewModel.play = true
                                                                }
                                                        }
                                                    }
                                                }
                                                .frame(width: 350, height: 390)
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                                .onDisappear {
                                    searchArray = []
                                    searchRadio = ""
                                    searchSet = false
                                }
                            }
                        }
                    }
                }
            }
            HStack {
                VStack {
//                    Spacer()
                    VolumeSliderView(horizontal: false, mute: true)
                        .frame(height: 200)
                        .padding(.bottom, 180)
//                    Spacer()
                }
                .offset(x:15)
                Spacer()
            }
            ZStack {
                    
                Rectangle()
                    .ignoresSafeArea()
                    .frame(width: 80)
                    .foregroundStyle(.raSearchBlue)
                VStack {
                    Spacer()
                    Image(systemName: "xmark")
                        .resizableToFit()
                        .frame(width: 20)
                        .padding(.vertical, 40)
                        .foregroundStyle(.white)
                        .onTapGesture {
                            viewModel.showTabBar = true
                            searchActive = false
                            searchRadio = ""
                        }
                }
                TabBarSearch(index: $tabIndex)
            }
            .offset(x: searchActive ? -160 : -300)
        }
        .animation(.easeInOut, value: searchActive)
    }
    
}

#Preview {
    AllStationView(viewModel: DataViewModel())
}

