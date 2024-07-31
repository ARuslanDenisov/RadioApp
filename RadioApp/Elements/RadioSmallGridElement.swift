import SwiftUI

struct RadioSmallGridElement: View {
    @State private var stations: [StationModel] = StationModel.sampleData()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 139))], spacing: 20) {
                ForEach(stations.indices, id: \.self) { index in
                    StationCardView(station: $stations[index])
                        .onTapGesture {
                            stations[index].isActive.toggle()
                        }
                }
            }
            .padding()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct StationCardView: View {
    @Binding var station: StationModel
    @State private var isHeartSelected = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(station.isActive ? Color.pink : Color.raDarkBlue)
                .frame(width: 139, height: 139)
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
//                            Button(action: {
//                                isHeartSelected.toggle()
//                            }) {
//                                Image(systemName: isHeartSelected ? "heart.fill" : "heart")
//                                    .foregroundColor(.white)
//                                    .padding(.trailing, 10)
//                            }
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

#Preview
{
    RadioSmallGridElement()
}
