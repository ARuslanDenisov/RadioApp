
import SwiftUI

struct PopularView: View {
    @StateObject var viewModel: DataViewModel
    @State private var stations: [StationModel] = StationModel.sampleData()
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
                    
                        ForEach(stations, id: \.id) { station in
                            if viewModel.stationNow.id == station.id {
                                RadioSmallGridElement(station: station, active: true )
                                    .onTapGesture {
                                        viewModel.stationNow = station
                                    }
                            } else {
                                RadioSmallGridElement(station: station, active: false )
                                    .onTapGesture {
                                        viewModel.stationNow = station
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




