
import SwiftUI

struct PopularView: View {
    @StateObject var viewModel: DataViewModel
    var body: some View {
        ZStack{
            Color.raDarkBlue
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                Text("Popular")
                    .foregroundStyle(.white)
                    .font(.custom(FontApp.regular, size: 30))
                    .padding(.top, 80)
                ScrollView{
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 139))], spacing: 15) {
                    
                        ForEach(viewModel.popular.indices, id: \.self) { index in
                            if viewModel.stationNow.id == viewModel.popular[index].id {
                                RadioSmallGridElement(station: viewModel.popular[index], active: true )
                                    .onTapGesture {
                                    
                                    }
                            } else {
                                RadioSmallGridElement(station: viewModel.popular[index], active: false )
                                    .onTapGesture {
                                        viewModel.indexRadio = index
                                        viewModel.stationNow = viewModel.popular[index]
                                        viewModel.radioPlayer.loadPlayer(from: viewModel.stationNow)
                                        viewModel.radioPlayer.playMusic()
                                    }
                            }
                                
                        }
                    }
                }
                .padding(.top, 20)
                .frame(width: 300, height: 480  )
                Spacer()
            }
          
            
            .animation(.easeInOut, value: viewModel.stationNow.id)
        }
    }
}

#Preview {
    NavigationView {
        PopularView(viewModel: DataViewModel(user: UserModel(id: "", name: "Mark", email: "", photoUrl: "", favorites: [StationModel(id: "12312312", name: "Radio da4a", favicon: "", streamUrl: "", tags: "Popular", language: "English", countryCode: "RU", votes: 35)]), stationNow: StationModel()))
    }
}




