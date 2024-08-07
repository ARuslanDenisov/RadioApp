//
//  RadioBigFavoriteElement.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct RadioBigFavoriteElement: View {
    var station: StationModel
    @State var animationStart: Bool
    @State var animationText: Bool = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(animationStart ? . raPink : .raDarkBlue)
            RoundedRectangle(cornerRadius: 15)
                .stroke(.raLightGray ,lineWidth: 0.8)
            HStack {
                VStack (alignment: .leading , spacing: 4 ){
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
                    
                    Text(station.tags.isEmpty ? "\(station.language)" : "\(station.tags)")
                        .foregroundStyle(.white)
                        .font(.custom(FontApp.regular, size: 15))
                        .lineLimit(1)
                    ZStack {
                        WaveAnimationElement(color: .raMediumBlue, animationStop: !animationStart)
                    }
                    .frame(width: 94, height: 23)
                }
                
                .padding(.horizontal, 22)
                Spacer()
            }
        }
        .frame(width: 293, height: 123)
        
        
    }
}

#Preview {
    RadioBigFavoriteElement(station: StationModel(id: "", name: "Arizona FM", favicon: "", streamUrl: "", tags: "popular music" , language: "English", countryCode: "", votes: 27), animationStart: false)
}
