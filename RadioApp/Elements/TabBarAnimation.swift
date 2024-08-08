//
//  GradientBG.swift
//  RadioApp
//
//  Created by Руслан on 06.08.2024.
//

import SwiftUI

struct TabBarAnimation: View {
    @State var animation: Bool
    @State var animationStart: Bool = false
    @State var animationStart2: Bool = false
    var body: some View {
        ZStack {
            sixAngleShape2()
                .stroke(lineWidth: animationStart ? 0 : 4)
                .foregroundStyle(.raPink)
                .offset(x: 0.6, y: -2.2)
                .scaleEffect(animationStart ? 2 : 0.9)
                .opacity(animationStart ? 0 : 0.8)
            sixAngleShape2()
                .stroke(lineWidth: animationStart2 ? 0 : 4)
                .foregroundStyle(.raLightBlue)
                .offset(x: 0.6, y: -2.2)
                .scaleEffect(animationStart2 ? 2 : 0.9)
                .opacity(animationStart2 ? 0 : 0.8)
        }
        .frame(width: 127, height: 127)
        .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: false), value: animationStart)
        .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: false), value: animationStart2)
        
        .onAppear {
            animationStart.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                animationStart2.toggle()
            }
            
        }
    }
}

#Preview {
    TabBarAnimation(animation: true)
}
