//
//  ContentView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI
import AVFoundation

struct RootView: View {
    @StateObject var viewModel = DataViewModel()
    
    
    var body: some View {
        
        ZStack {
            Color.raDarkBlue
                .ignoresSafeArea()
            NavigationView {
                switch viewModel.tabBarIndex {
                case 0: PopularView(viewModel: viewModel)
                case 1: FavoriteView(viewModel: viewModel)
                case 2: AllStationView(viewModel: viewModel)
                default: PopularView(viewModel: viewModel)
                }

            }
            .navigationViewStyle(.stack)
            // authView
            if viewModel.showAuthView {
                NavigationView {
                    AuthView(mainViewModel: viewModel, showAuthView: $viewModel.showAuthView)
                        .opacity(viewModel.showAuthView ? 1 : 0)
                }
            }
            //header and tabBar
            if !viewModel.showAuthView {
                VStack {
                    //header
                    VStack {
                        HStack(spacing: 0) {
                            Button {  print(viewModel.user) } label: {
                                Image("appLogo")
                                    .resizableToFit()
                                    .frame(width: 33)
                                    .padding(.trailing, 7)
                            }
                            Text("Hello, ")
                                .foregroundStyle(.white)
                                .font(.custom(FontApp.bold, size: 30))
                            Text(viewModel.user.name)
                                .foregroundStyle(.raPink)
                                .font(.custom(FontApp.bold, size: 30))
                            Spacer()
                            NavigationLink {
                                ProfileView(viewModel: viewModel)
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundStyle(.white)
                                    Image(uiImage: viewModel.userPhoto)
                                        .resizableToFit()
                                }
                                .clipShape(TriangleShape())
                            }
                            .frame(width: 40,height: 40)
                            
                        }
                        .padding(5)
                        Spacer()
                    }
                    //playButtons
                    HStack (spacing: 30) {
                        Button {
                            viewModel.prevStation()
                            viewModel.radioPlayer.loadPlayer(from: viewModel.stationNow)
                            viewModel.radioPlayer.playMusic()
                            viewModel.play = true
                        } label: {
                            RadioButtonsView(play: false, state: .left)
                        }
                        Button {
                            if viewModel.play {
                                viewModel.radioPlayer.pauseMusic()
                                viewModel.play = false
                            } else {
                                if viewModel.stationNow.id.isEmpty {
                                    viewModel.radioPlayer.loadPlayer(from: viewModel.popular[0])
                                    viewModel.stationNow = viewModel.popular[0]
                                    viewModel.radioPlayer.playMusic()
                                    viewModel.play = true
                                } else {
                                    viewModel.radioPlayer.loadPlayer(from: viewModel.stationNow)
                                    viewModel.radioPlayer.playMusic()
                                    viewModel.play = true
                                }
                            }
                            
                        } label: {
                            if viewModel.play {
                                RadioButtonsView(play: true , state: .play)
                            } else {
                                RadioButtonsView(play: false , state: .play)
                            }
                            
                        }
                        Button {
                            viewModel.nextStation()
                            viewModel.radioPlayer.loadPlayer(from: viewModel.stationNow)
                            viewModel.radioPlayer.playMusic()
                            viewModel.play = true
                        } label: {
                            RadioButtonsView(play: false, state: .right)
                        }
                    }
                        .padding(10)
                    //tabbar
                    TabBarView(selectedTab: $viewModel.tabBarIndex)
                }
                .opacity(viewModel.showAuthView ? 0 : 1)
            }
        }
        .fullScreenCover(isPresented: $viewModel.showDetailView, content: {
            StationDetailView(viewModel: viewModel)
        })
        //animation
        
        .animation(.easeInOut(duration: 1), value: viewModel.tabBarIndex)
        .animation(.easeInOut(duration: 0.5), value: viewModel.user.name)
        .animation(.easeInOut(duration: 1), value: viewModel.showAuthView)
        
        .onAppear {
            
        }
    }

}

#Preview {
    NavigationView {
        RootView()
    }
}
