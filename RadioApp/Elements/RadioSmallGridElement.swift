import SwiftUI


//class StationsViewModel: ObservableObject {
//    @Published var stations: [StationModel]
//
//    init(stations: [StationModel]) {
//        self.stations = stations
//    }
//
//    func activate(station: StationModel) {
//        for i in 0..<stations.count {
//            stations[i].isActive = stations[i].id == station.id
//        }
//    }
//}
struct RadioSmallGridElement: View {
   // @StateObject var viewModel = StationsViewModel(stations: StationModel.sampleData())
    @Binding var station: StationModel
    @State private var isHeartSelected = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(station.isActive ? Color.pink : Color.raDarkBlue)
                .frame(width: 139, height: 139)
                .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(
                                        Color.gray
                                    ))
            
//                .onTapGesture {
//                                    viewModel.activate(station: station)
//                                }
            
             .overlay(
                    VStack {
                        HStack {
                            Image(systemName: "play.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 37))
                                .padding(.leading, 0)
                            Spacer()
                            Text("votes \(station.votes)")
                                .foregroundColor(station.isActive ? .white : .gray)
                                .font(.system(size: 12))
                                .padding(.trailing, 5)

                        }
                        Spacer()
                        Text(station.name)
                            .bold()
                            .font(.title2)
                            .foregroundColor(station.isActive ? .white : .gray)
                        Text(station.tags)
                            .font(.caption)
                            .foregroundColor(station.isActive ? .white : .gray)
                        Spacer()
                        // Placeholder for animation
                        Rectangle()
                            .frame(width: 100, height: 20)
                            .foregroundColor(.gray)
                            .cornerRadius(10)
                            .padding(.bottom, 10)
                    }
                    .padding()
           )
        }
        .animation(.easeInOut, value: station.isActive)
    }
}



