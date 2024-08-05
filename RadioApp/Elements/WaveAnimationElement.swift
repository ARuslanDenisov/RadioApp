//
//  WaveAnimationElement.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct WaveAnimationElement: View {
    var color: Color = Color(.raPink)
    @State var animationStop: Bool = false
    var body: some View {
        ZStack {
            Wave4(phase: animationStop ? 1 : ( 2.3 * .pi ) , strength: 7, frequency: 30)
                
                .stroke(Color.white, lineWidth: 3)
                .frame(width: 89, height: 23)
                
            HStack {
                Circle()
                    .frame(width: 7)
                    .foregroundStyle(color)
                Spacer()
                Circle()
                    .frame(width: 7)
                    .foregroundStyle(color)
            }
        }
//        .background(.raDarkBlue)

        .frame(width: 94, height: 23)

        .animation(
            animationStop ? .linear(duration: 0.7).repeatForever(autoreverses: false) :
                    .bouncy(duration: 1.0, extraBounce: 0.3), value: animationStop)
//        .animation(animationStart ? .linear.repeatForever() : .default, value: animationStart)
        .onAppear {
            animationStop = true
        }
        
    }
    
        
        
}

struct Wave4: Shape {
    var phase: Double
    // how high our waves should be
    var strength: Double
    var animatableData: Double {
        get { phase }
        set { self.phase = newValue }
    }
    // how frequent our waves should be
    var frequency: Double
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        
        // calculate some important values up front
        let width = Double(rect.width)
        let height = Double(rect.height)
        let midWidth = width / 2
        let midHeight = height / 2
        let oneOverMidWidth = 1 / midWidth
        
        // split our total width up based on the frequency
        let wavelength = width / frequency
        
        // start at the left center
        path.move(to: CGPoint(x: 0, y: midHeight))
        
        // now count across individual horizontal points one by one
        for x in stride(from: 0, through: width + 2, by: 2) {
            // find our current position relative to the wavelength
            let relativeX = x / wavelength
            // find how far we are from the horizontal center
            let distanceFromMidWidth = x - midWidth

            // bring that into the range of -1 to 1
            let normalDistance = oneOverMidWidth * distanceFromMidWidth
            let parabola = -(normalDistance * normalDistance) + 1
            // calculate the sine of that position
            let sine = sin(relativeX + phase)
            
            // multiply that sine by our strength to determine final offset, then move it down to the middle of our view
            let y = parabola * strength * sine + midHeight
            
            // add a line to here
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        return Path(path.cgPath)
    }
}


#Preview {
    WaveAnimationElement()
}
