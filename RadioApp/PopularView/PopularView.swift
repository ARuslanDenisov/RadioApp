
import SwiftUI

struct PopularView: View {
    @StateObject var viewModel: DataViewModel
    @EnvironmentObject var languageManager: LanguageManager
  
    var body: some View {
        ZStack {
            Color.raDarkBlue
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                Text("Popular".localized)
                    .foregroundStyle(.white)
                    .font(.custom(FontApp.regular, size: 30))
                    .padding(.top, 80)
                ScrollView (showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 139))], spacing: 15) {
                    
                        ForEach(viewModel.popular.indices, id: \.self) { index in
                            ZStack {
                                if viewModel.stationNow.id == viewModel.popular[index].id {
                                    RadioSmallGridElement(station: viewModel.popular[index], active: true )
                                    
                                        .onLongPressGesture(minimumDuration: 1.0) {
                                            viewModel.showDetailView = true
                                        }
                                } else {
                                    RadioSmallGridElement(station: viewModel.popular[index], active: false )
                                        .onTapGesture {
                                            viewModel.indexRadio = index
                                            viewModel.stationNow = viewModel.popular[index]
                                            viewModel.radioPlayer.loadPlayer(from: viewModel.stationNow)
                                            viewModel.radioPlayer.playMusic()
                                            viewModel.play = true
                                        }
                                        
                                }
                                //heart elements
                                HStack {
                                    Spacer()
                                    VStack {
                                        Image(systemName: viewModel.checkFavorite(station: viewModel.popular[index]) ? "heart.fill" : "heart")
                                            .resizableToFit()
                                            .frame(width: 13)
                                            .foregroundStyle(.white)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 15)
                                            .onTapGesture {
                                                
                                            }
                                        Spacer()
                                    }
                                }
                                .frame(width: 139, height: 139)
                            }
                        }
                    }
                }
                .padding(.top, 20)
                .frame(width: 300, height: 480  )
                Spacer()
            }
            //
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
            .animation(.easeInOut, value: viewModel.stationNow.id)
        }
        .onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

#Preview {
    NavigationView {
        PopularView(viewModel: DataViewModel(user: UserModel(id: "", name: "Mark", email: "", photoUrl: "", favorites: [StationModel(id: "12312312", name: "Radio da4a", favicon: "", streamUrl: "", tags: "Popular", language: "English", countryCode: "RU", votes: 35)]), stationNow: StationModel()))
    }
}




