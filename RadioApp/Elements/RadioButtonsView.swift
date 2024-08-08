//
//  RadioButtonsView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct RadioButtonsView: View {
    @StateObject var viewModel: DataViewModel
    var body: some View {
        HStack (spacing: 30) {
            Button {
                viewModel.prevStation()
                viewModel.radioPlayer.loadPlayer(from: viewModel.stationNow)
                viewModel.radioPlayer.playMusic()
                viewModel.play = true
            } label: {
                RadioButtonsElements(state: .left, play: false)
            }
            Button {
                if viewModel.play {
                    viewModel.radioPlayer.pauseMusic()
                    viewModel.play = false
                } else {
                    if viewModel.stationNow.id.isEmpty {
                        viewModel.radioPlayer.loadPlayer(from: viewModel.popular[0])
                        viewModel.stationNow = viewModel.popular[0]
                        viewModel.radioPlayer.playMusic()
                        viewModel.play = true
                    } else {
                        viewModel.radioPlayer.loadPlayer(from: viewModel.stationNow)
                        viewModel.radioPlayer.playMusic()
                        viewModel.play = true
                    }
                }
                
            } label: {
                if viewModel.play {
                    RadioButtonsElements(state: .play, play: true)
                } else {
                    RadioButtonsElements(state: .play, play: false)
                }
                
            }
            Button {
                viewModel.nextStation()
                viewModel.radioPlayer.loadPlayer(from: viewModel.stationNow)
                viewModel.radioPlayer.playMusic()
                viewModel.play = true
            } label: {
                RadioButtonsElements(state: .right, play: false)
            }
        }
            .padding(10)
            
    }
}

#Preview {
    RadioButtonsView(viewModel: DataViewModel())
}

enum StateButton {
    case play
    case left
    case right
}
struct RadioButtonsElements: View {
    @State var state: StateButton
    @State var play: Bool
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
//            RadialGradient(colors: [Color.black, Color.clear], center: .center, startRadius: 140, endRadius: 200)
//            EllipticalGradient(colors:[Color.raDarkBlue, Color.clear], center: .center, startRadiusFraction: 0.4, endRadiusFraction: 0.5)
//                .rotationEffect(.degrees(90))
//                .offset(y: 140 )
   
