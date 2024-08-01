//
//  RadioBigAllStationElement.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct RadioBigAllStationElement: View {
    var dataVM: DataViewModel
    @State var playingNow: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(playingNow ? .raPink : .raDarkBlue )
            RoundedRectangle(cornerRadius: 15)
                .stroke(.raLightGray)
            
            HStack {
                Spacer()
                VStack {
                    Text("votes \(dataVM.stationNow.votes)")
                        .foregroundStyle(.white)
                        .font(.custom(FontApp.bold, size: 10))
                    Spacer()
                }
            }
            .padding(10)
            
            VStack(alignment: .leading) {
                Text(dataVM.stationNow.name)
                    .foregroundStyle(.white)
                    .font(.custom(FontApp.bold, size: 30))
                
                HStack {
                    Text(dataVM.stationNow.tags.isEmpty ? "Popular" : "\(dataVM.stationNow.tags)")
                        .foregroundStyle(.white)
                    .font(.custom(FontApp.regular, size: 15))
                    Spacer()
                    ZStack{
                        Color.blue
                    }
                    .frame(width: 94, height: 23)
                }
                
                Text(playingNow ? "Playing now" : "")
                    .foregroundStyle(.gray)
                    .opacity(0.8)
                    .font(.custom(FontApp.bold, size: 14))
            }
            .padding(.horizontal, 22)
        }
        .frame(width: 293, height: 123)
    }
}

#Preview {
    RadioBigAllStationElement(dataVM: DataViewModel(user: UserModel(id: "", name: "Mark", email: "", photoUrl: "", favorites: []), stationNow: StationModel()), playingNow: true)
}
