
import SwiftUI

struct PopularView: View {
    @StateObject var viewModel: DataViewModel
    @State private var stations: [StationModel] = StationModel.sampleData()
    var body: some View {
        ZStack{
            Color.raDarkBlue
                .ignoresSafeArea()
            //Header
            VStack {
                HStack(spacing: 0) {
                    Image("appLogo")
                        .resizableToFit()
                        .frame(width: 33)
                        .padding(.trailing, 7)
                    Text("Hello, ")
                        .foregroundStyle(.white)
                        .font(.custom(FontApp.bold, size: 30))
                    Text(viewModel.user.name.isEmpty ? "New user" : viewModel.user.name)
                        .foregroundStyle(.raPink)
                        .font(.custom(FontApp.bold, size: 30))
                    Spacer()
                    NavigationLink {
                        ProfileView()
                    } label: {
                        //тут будет картинка пользователя
                        Image("")
                            .resizableToFit()
                        ZStack {
                            Rectangle()
                                .foregroundStyle(.white)
                        }
                        .clipShape(TriangleShape().offset(x:-20, y: 15))
                        
                        
                    }
                    .frame(width: 30,height: 30)
                    
                }
                .padding(5)
                Spacer()
            }
            
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Popular")
                    .foregroundStyle(.white)
                    .font(.custom(FontApp.regular, size: 30))
                    .padding(.top, 100)
                ScrollView{
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 139))], spacing: 15) {
                    
                        ForEach(stations.indices, id: \.self) { index in
                            RadioSmallGridElement(station: $stations[index])
//                                .environmentObject(viewModel)
                                .onTapGesture {
                                    stations[index].isActive.toggle()
                                }
                        }
                    }
                }
                .padding(.top, 20)
                .frame(width: 300, height: 480  )
                Spacer()
            }
          
            
            
        }
    }
}

#Preview {
    NavigationView {
        PopularView(viewModel: DataViewModel(user: UserModel(id: "", name: "Mark", email: "", photoUrl: "", favorites: [StationModel(id: "12312312", name: "Radio da4a", favicon: "", streamUrl: "", tags: "Popular", language: "English", countryCode: "RU", votes: 35)]), stationNow: StationModel()))
    }
}




