import SwiftUI



struct RadioSmallGridElement: View {
    @State var station: StationModel
    @State var active: Bool
    @State private var isHeartSelected = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(active ? Color.pink : Color.raDarkBlue)
                .frame(width: 139, height: 139)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(
                            Color.gray
                        ))

            VStack {
                HStack {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 37))
                        .padding(.leading, 0)
                    Spacer()
                    Text("votes \(station.votes)")
                        .foregroundColor(active ? .white : .gray)
                        .font(.system(size: 12))
                        .padding(.trailing, 5)
                    
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
                WaveAnimationElement(color: .raPink, animationStop: active )
                                      Rectangle()
                    .frame(width: 100, height: 20)
                    .foregroundColor(.gray)
                    .cornerRadius(10)
                    .padding(.bottom, 10)
            }
            .padding()
            
        }
        .animation(.easeInOut, value: active)
    }
}




#Preview {
    RadioSmallGridElement(station: StationModel(), active: true)
}
