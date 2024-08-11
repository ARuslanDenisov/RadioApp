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
    @EnvironmentObject var languageManager: LanguageManager
    @Environment (\.dismiss) var dismiss
    @State var animation = false
    @State var animationText = false
    @State var vote = false
    var body: some View {
        
        ZStack {
            VStack {
                ZStack {
                    ZStack {
                        if viewModel.play{
                            EqualizerView(animationStop: false)
                                .opacity(0.3)
                                .brightness(1.2)
                                .blur(radius: 5)
                                .scaleEffect(1.3)
                            EqualizerView(animationStop: false)
                                .scaleEffect(y: 0.7)
                        } else {
                            EqualizerView(animationStop: true)
                        }
                    }
                    HStack {
                        VStack {
                            VStack {
                                Text(viewModel.stationNow.name)
                                    .foregroundStyle(.white)
                                    .font(.custom(FontApp.bold, size: 40))
                                    .lineLimit(1)
                                    .frame(width: 900)
                                    .offset(x: animationText ? -CGFloat(viewModel.stationNow.name.count * 7) : CGFloat(viewModel.stationNow.name.count * 7) )
                                    .animation(Animation.linear(duration: 8).repeatForever(autoreverses: true))
                                    .onAppear {
                                        self.animationText.toggle()
                                    }
                            }
                            .frame(width: 200)
                            .clipShape(Rectangle())
                            Text(viewModel.stationNow.tags)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .font(.custom(FontApp.light, size: 12))
                                .frame(width: 200)
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
                ZStack {
                    if viewModel.play {
                        TabBarAnimation(animation: true)
                            .frame(height: 100)
                            .scaleEffect(1.4)
                    }
                    RadioButtonsView(viewModel: viewModel)
                    HStack {
                        Button {
                            Task {
                                try await NetworkServiceAA.shared.voteForStation(station: viewModel.stationNow)
                            }
                            vote = true
                        } label: {
                            Image(systemName: !vote ? "hand.thumbsup" : "hand.thumbsup.fill" )
                                .resizableToFit()
                                .foregroundStyle(.white)
                                .frame(width: 20, height: 20)
                                .padding(20)
                        }
                        Spacer()
                        Button {
                            if viewModel.checkFavorite(station: viewModel.stationNow) { 
                                viewModel.toFavorite(station: viewModel.stationNow)
                                Task {
                                    try await FBFirestoreService.shared.deleteFavoriteStation(user: viewModel.user ,station: viewModel.stationNow )
                                    }
                            } else {
                                viewModel.toFavorite(station: viewModel.stationNow )
                            }
                        } label: {
                            Image(systemName: viewModel.checkFavorite(station: viewModel.stationNow) ? "heart.fill" : "heart")
                                .resizableToFit()
                                .foregroundStyle(.raPink)
                                .frame(width: 20, height: 20)
                                .padding(20)
                        }
                        
                    }
                }
                HStack {
                    VolumeSliderView(horizontal: true, mute: true)
                        .frame(width: 300, height: 40)
                        .padding(.top, 30)
                        
                }
                
            }
//            .padding(.bottom, 286)
        }
        .animation(.linear(duration: 3.0).repeatForever(autoreverses: false), value: animation)
        .animation(.easeInOut, value: viewModel.play)
        .background(Image("bg").ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Playing now".localized)
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
        StationDetailView(viewModel: DataViewModel(user: UserModel(), stationNow: StationModel(id: "", name: "Dacha kva4a privet kak dela FM", favicon: "https://www.newstalkzb.co.nz/content/news/images/interface/icons/newstalkzb/apple-touch-icon.png", streamUrl: "", tags: "pop rock, falklor things bad and another words that you can type", language: "", countryCode: "Ru", votes: 131)))
    }
}
