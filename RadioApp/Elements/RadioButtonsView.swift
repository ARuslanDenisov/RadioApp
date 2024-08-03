//
//  RadioButtonsView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct RadioButtonsView: View {
    @State var play: Bool
    @State var state: StateButton
    var body: some View {
            ZStack {
                if state == .play {
                    ZStack {
                        Image("playButton")
                            .resizableToFit()
                        Image(systemName: !play ? "play.fill" : "pause.fill")
                            .resizableToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.white)
                            .offset(x: !play ? 4 : 0 )
                        
                    }
                    .frame(width: 89, height: 89)
                } else {
                    ZStack {
                        Image ("switchButton")
                            .resizableToFit()
                        Image (systemName: state == .left ? "arrowtriangle.left.fill" : "arrowtriangle.right.fill")
                            .resizableToFit()
                            .frame(width: 17, height: 17)
                            .offset(x: state == .left ? -3 : 3)
                            .foregroundStyle(.white)
                    }
                    .frame(width: 48, height: 48)
                }
            }
    }
}

#Preview {
    RadioButtonsView(play: false, state: .play)
}

enum StateButton {
    case play
    case left
    case right
}

//            RadialGradient(colors: [Color.black, Color.clear], center: .center, startRadius: 140, endRadius: 200)
//            EllipticalGradient(colors:[Color.raDarkBlue, Color.clear], center: .center, startRadiusFraction: 0.4, endRadiusFraction: 0.5)
//                .rotationEffect(.degrees(90))
//                .offset(y: 140 )
   
