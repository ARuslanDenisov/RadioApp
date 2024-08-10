//
//  RadioBigAllStationElement.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct RadioBigAllStationElement: View {
    var station: StationModel
    @EnvironmentObject var languageManager: LanguageManager
    @State var playingNow: Bool
    @State var animationText = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(playingNow ? .raPink : .raDarkBlue)
            if !playingNow {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.raLightGray, lineWidth: 0.8)
            }
            HStack {
                Spacer()
                VStack {
                    Text("\("votes".localized) \(formatVotes(votes: station.votes))")
                        .foregroundStyle(.white)
                        .font(.custom(FontApp.bold, size: 10))
                        .padding(.trailing, 20)
                    Spacer()
                }
            }
            .padding(10)
            
            VStack(alignment: .leading, spacing: 10) {
                VStack {
                    Text(station.name)
                        .foregroundStyle(.white)
                        .font(.custom(FontApp.bold, size: 30))
                        .frame(width: 900)
                        .offset(x: animationText ? -CGFloat(station.name.count * 7) : CGFloat(station.name.count * 7) )
                        .animation(Animation.linear(duration: 8).repeatForever(autoreverses: true))
                        .onAppear {
                            self.animationText.toggle()
                        }
                }
                
                .frame(width: 150)
                .clipShape(Rectangle())
                
                HStack {
                  Text(station.tags.isEmpty ? "Popular".localized : "\(station.tags)")
                        .foregroundStyle(.white)
                        .font(.custom(FontApp.regular, size: 15))
                    Spacer()
                    ZStack{
                        WaveAnimationElement(color: .raPlayingNowText, animationStop: !playingNow)
                    }
                    .frame(width: 94, height: 23)
                }
                
              Text(playingNow ? "Playing now".localized : "")
                    .foregroundStyle(.raPlayingNowText)
                    .opacity(0.8)
                    .font(.custom(FontApp.bold, size: 14))
            }
            .padding(.horizontal, 22)
        }
        .frame(width: 293, height: 123)
    }
    func formatVotes(votes: Int) -> String {
        votes > 999 ? "\(votes/1000)K" : "\(votes)"
    }
}

#Preview {
    RadioBigAllStationElement(station: StationModel(id: "", name: "Radio Record", favicon: "", streamUrl: "", tags: "Pop", language: "", countryCode: "", votes: 200), playingNow: true)
}
