import SwiftUI



struct RadioSmallGridElement: View {
    @State var station: StationModel
    @State var active: Bool
    @State private var isHeartSelected = false
    @EnvironmentObject var languageManager: LanguageManager

    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(active ? .raPink : Color.raDarkBlue)
                   
                if !active {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(
                            Color.gray
                        )
                }
            }
            .frame(width: 139, height: 139)

            VStack {
                HStack {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 37))
                        .padding(.leading, 0)
                        .opacity(active ? 1 : 0)
                    Spacer()
                 
                    
                }
               
                Spacer()
                Text(station.name)
                    .bold()
                    .font(.title2)
                    .foregroundColor(active ? .white : .gray)
                Text(station.tags)
                    .font(.caption)
                    .foregroundColor(active ? .white : .gray)
                Spacer()
                WaveAnimationElement(color: .raPlayingNowText, animationStop: !active )
                    .frame(width: 94, height: 23)
                    
            }
            .padding()
            VStack {
                HStack {
                    Spacer()
                  Text("votes %@" .localized(with: formatVotes(votes: station.votes)))
                        .foregroundColor(active ? .white : .gray)
                        .font(.custom(FontApp.bold , size: 10))
                        .padding(20)
                        .padding(.trailing, 10)
                    
                    
                }
                Spacer()
            }
            
        }
        .frame(width: 139, height: 139)
        .animation(.easeInOut, value: active)
    }
    func formatVotes(votes: Int) -> String {
        votes > 999 ? "\(votes/1000)K" : "\(votes)"
    }
}




#Preview {
    RadioSmallGridElement(station: StationModel(id: "1", name: "Radio Death", favicon: "", streamUrl: "", tags: "rock", language: "English", countryCode: "", votes: 121), active: false)
}
