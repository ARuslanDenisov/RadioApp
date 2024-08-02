//
//  RadioButtonsView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct RadioButtonsView: View {
    @Binding var play: Bool
    @Binding var next: Bool
    @Binding var prev: Bool
    var body: some View {
        ZStack {
//            RadialGradient(colors: [Color.black, Color.clear], center: .center, startRadius: 140, endRadius: 200)
//            EllipticalGradient(colors:[Color.raDarkBlue, Color.clear], center: .center, startRadiusFraction: 0.4, endRadiusFraction: 0.5)
//                .rotationEffect(.degrees(90))
//                .offset(y: 140 )
            
            ZStack {
                HStack {
                    ZStack {
                        Image ("switchButton")
                            .resizableToFit()
                        Image (systemName: "arrowtriangle.left.fill")
                            .resizableToFit()
                            .frame(width: 17, height: 17)
                            .offset(x: -3)
                            .foregroundStyle(.white)
                    }
                    .frame(width: 48, height: 48)
                    .onTapGesture {
                        play.toggle()
                    }
                    Spacer()
                    ZStack {
                        Image ("switchButton")
                            .resizableToFit()
                        Image (systemName: "arrowtriangle.right.fill")
                            .resizableToFit()
                            .frame(width: 17, height: 17)
                            .offset(x: 3)
                            .foregroundStyle(.white)
                    }
                    .frame(width: 48, height: 48)
                    .onTapGesture {
                        play.toggle()
                    }
                }
                ZStack {
                    Image("playButton")
                        .resizableToFit()
                    Image(systemName: play ? "play.fill" : "pause.fill")
                        .resizableToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                        .offset(x: play ? 4 : 0 )
                    
                }
                .frame(width: 89, height: 89)
                .onTapGesture {
                    play.toggle()
                }
            }
            
            .frame(width: 255)
        }
    }
}

#Preview {
    RadioButtonsView(play: .constant(false), next: .constant(true), prev: .constant(true))
}
