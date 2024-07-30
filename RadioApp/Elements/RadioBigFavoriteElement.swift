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
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.raDarkBlue)
            RoundedRectangle(cornerRadius: 10)
                .stroke(.raLightGray ,lineWidth: 0.8)
            HStack {
                VStack (alignment: .leading , spacing: 4 ){
                    Text(station.name)
                        .foregroundStyle(.white)
                        .font(.custom(FontApp.bold, size: 30))
                    
                    Text(station.tags.isEmpty ? "\(station.language)" : "\(station.tags)")
                        .foregroundStyle(.white)
                        .font(.custom(FontApp.regular, size: 15))
                    ZStack{
                      //Animation
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
