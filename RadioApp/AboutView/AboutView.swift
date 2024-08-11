//
//  AboutView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//
//    https://ia804603.us.archive.org/4/items/official-rickroll-download-pls-dont-give-me-copyright-strike/Official%20Rickroll%20Download%20%28Pls%20don%27t%20give%20me%20copyright%20strike%29.mp3
import SwiftUI

struct AboutView: View {
    @StateObject var viewModel: DataViewModel
    @State var animation = false
    @State var secondText = false
    @State var showHi = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("bg")
                    .ignoresSafeArea()
                
                VStack {
                    GifImageView("stars")
                        .blendMode(.lighten)
                    GifImageView("stars")
                        .blendMode(.lighten)
                }
                .frame(height: 600)
                
                ScrollView(showsIndicators: false ) {
                    VStack {
                        Spacer(minLength: secondText ? 0 : 900)
                        Text(
                            "\n\nYou might have heard about the idea of wearing a foil hat to protect yourself from the effects of radio waves. While this concept has gained some popularity, there's no scientific evidence to support the claim that such hats can shield your brain from harmful radiation. In fact, radio waves are a form of non-ionizing radiation, which means they don't have enough energy to damage DNA.".localized
                        )
                        .font(.custom(FontApp.regular, size: 18))
                        .foregroundStyle(.white)
                        Text(
                            "\n\nSo instead of worrying about radio waves, why not focus on enjoying the positive aspects of radio? Our app offers a safe and convenient way to tune in to your favorite shows and discover new ones. Explore a vast library of radio stations, from classic hits to cutting-edge podcasts. Whether you're looking for news, sports, or simply some background music, we've got you covered".localized
                        )
                        .font(.custom(FontApp.regular, size: 18))
                        .foregroundStyle(.white)
                        Text("\nStay tuned for more updates and let's have some real rick-rolling!".localized)
                            .font(.custom(FontApp.regular, size: 18))
                            .foregroundStyle(.white)
                        
                    }.padding()
                }
                .frame(width: 350)
                .padding(.top, 15)
                
                VStack {
                    Spacer()
                    ZStack {
                        Image("ball")
                            .resizableToFit()
                            .frame(width: 250)
                            .rotationEffect(.degrees(animation ? 0 : 20), anchor: .center)
                            .offset(y: -600)
                        Image("rickRoll")
                            .scaledToFit()
                            .scaleEffect(0.6)
                            .offset(y: 100)
                            .rotationEffect(.degrees(animation ? -7 : 7),anchor: .bottom)
                            .onTapGesture {
                                showHi.toggle()
                            }
                        if showHi {
                            ZStack {
                                Image("speak")
                                    .resizableToFit()
                                    .offset(y: 20)
                                Text("Swift марафон привет!")
                                    .font(.custom(FontApp.bold, size: 20))
                            }
                            .frame(width: 200, height: 200)
                            .offset(x: 110, y: -40)
                        }
                    }
                }
                
                .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: animation)
                
            }
            .animation(.easeOut(duration: 2), value: secondText)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("About us")
                        .font(.custom(FontApp.semiBold, size: 24))
                        .foregroundColor(.white)
                        .padding(5)
                        .background(.raPink)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
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
                viewModel.radioPlayer.playMusicWithURL(StationModel(id: "", name: "", favicon: "", streamUrl: "https://ia804603.us.archive.org/4/items/official-rickroll-download-pls-dont-give-me-copyright-strike/Official%20Rickroll%20Download%20%28Pls%20don%27t%20give%20me%20copyright%20strike%29.mp3", tags: "", language: "", countryCode: "", votes: 1))
                animation.toggle()
                secondText.toggle()
            }
            
            .onDisappear{
                viewModel.radioPlayer.loadPlayer(from: viewModel.stationNow)
                viewModel.radioPlayer.playMusicWithURL(viewModel.stationNow)
                viewModel.radioPlayer.playMusic()
                viewModel.play = true
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
}

#Preview {
    NavigationView {
        AboutView(viewModel: DataViewModel())
    }
}
