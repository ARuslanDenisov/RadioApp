//
//  EqualizerView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct EqualizerView: View {
    var valueOfBars: CGFloat = 21
    @State var animationStart = false
    @State var animationStop = false
    @State var random = CGFloat.random(in: 0...450)
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach (0..<Int(valueOfBars)) { index in
                    EqualizerSingleView()
                        .offset(x: CGFloat((geo.size.width / valueOfBars) * CGFloat(index)))
//                        .scaleEffect(animationStart ? CGFloat(Double.random(in: 0...1)) : 1, anchor: .bottom)
                        .frame(height: animationStop ? 20 : animationStart ? CGFloat.random(in: CGFloat(index * 5)...350) : 300, alignment: .center)
                }
                .foregroundStyle(Gradient(colors: [.raLightBlue, .raPink]))
                
                Button {} label : {}
            }
            .frame(height: 450)
            .onAppear {
                animationStart = true
            }
            .animation(.easeInOut(duration: 0.2).repeatForever(autoreverses: false), value: animationStart)
            .animation(.easeInOut, value: animationStop)
            
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                animationStart.toggle()
                        }
        }
    }

    
}
struct EqualizerSingleView: View {
    var body: some View {
        line()
            .stroke(style: .init(lineWidth: 5 , lineCap: CGLineCap.round, lineJoin: .round, miterLimit: 110, dash: [1, 13], dashPhase: 1))
    }
}

#Preview {
    EqualizerView()
}
