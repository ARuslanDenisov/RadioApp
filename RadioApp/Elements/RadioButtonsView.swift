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

#Preview {
    RadioButtonsView(play: .constant(false), next: .constant(true), prev: .constant(true))
}
