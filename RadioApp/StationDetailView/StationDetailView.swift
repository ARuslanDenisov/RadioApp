//
//  StationDetailView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI
import Kingfisher

struct StationDetailView: View {
    @StateObject var viewModel: DataViewModel
    @Environment (\.dismiss) var dismiss
    @State var animation = false
    var body: some View {
        
        ZStack {
            VStack {
                ZStack {
                    // TODO: equalizer!!!!
                    HStack {
                        VStack {
                            Text(viewModel.stationNow.name)
                                .foregroundStyle(.white)
                                .font(.custom(FontApp.bold, size: 40))
                            Text(viewModel.stationNow.tags)
                                .foregroundStyle(.white)
                                .font(.custom(FontApp.regular, size: 20))
                            Spacer()
                        }
                    }
                    HStack {
                        Spacer()
                        VStack {
                            KFImage(URL(string: viewModel.stationNow.favicon))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .rotationEffect(.degrees(animation ? 0 : 360))
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 10)
                }
                .frame(height: 448)
                Spacer()
//                //playButtons
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
                HStack {
                    VolumeSliderView(value: 100.0 , horizontal: true, mute: true)
                        .frame(width: 300, height: 40)
                        .padding(.top, 30)
                        
                }
                
            }
//            .padding(.bottom, 286)
        }
        .animation(.linear(duration: 3.0).repeatForever(autoreverses: false), value: animation)
        .background(Image("bg").ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Playing now")
                    .font(.custom(FontApp.semiBold, size: 24))
                    .foregroundColor(.white)
            }
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label : {
                    Image(systemName: "arrow.left")
                        .resizableToFit()
                        .foregroundStyle(.white)
                }
            }
        }
        .onAppear {
            animation.toggle()
        }
    }
}

#Preview {
    NavigationView {
        StationDetailView(viewModel: DataViewModel(user: UserModel(), stationNow: StationModel(id: "", name: "Dacha FM", favicon: "https://www.newstalkzb.co.nz/content/news/images/interface/icons/newstalkzb/apple-touch-icon.png", streamUrl: "", tags: "pop rock", language: "", countryCode: "Ru", votes: 131)))
    }
}
