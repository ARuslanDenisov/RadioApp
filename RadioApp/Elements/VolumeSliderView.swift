//
//  VolumeSliderView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct VolumeSliderView: View {
    @State var value: Double
    @State var lastCoordinateValue: CGFloat = 0.0
    var horizontal : Bool
    @State var mute: Bool
    @State var volume: Double
    var body: some View {
        GeometryReader { gr in
            let radius = 0.01
            let minValue = 0.0
            let maxValue = 190.0
            
            ZStack {
                ZStack {
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 200, height: 2)
                        Spacer()
                    }
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.raLightBlue)
                            .frame(width: value, height: 2, alignment: .leading)
                        Spacer()
                    }
                    
                }
                HStack {
                    Circle()
                        .foregroundColor(Color.raLightBlue)
                        .frame(width: 10, height: 10)
                        .offset(x: self.value)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { v in
                                    if (abs(v.translation.width) < 0.1) {
                                        self.lastCoordinateValue = self.value
                                    }
                                    if v.translation.width > 0 {
                                        self.value = min(maxValue, self.lastCoordinateValue + v.translation.width)
                                    } else {
                                        self.value = max(minValue, self.lastCoordinateValue + v.translation.width)
                                    }
                                    
                                }
                        )
                    Spacer()
                }
            }
        }
//        ZStack {
//            Color.raDarkBlue
//            VStack {
//                
//                Text("\(Int(volume * 100))%")
//                    .foregroundColor(.white)
//                    .font(.title2)
//                    .padding(.bottom, 100)
//                
//                Slider(value: $volume, in: 0...1)
//                    .foregroundColor(.black)
//                    .rotationEffect(.degrees(-90))
//                    .frame(width: 200, height: 40)
//                    .accentColor(.raLightBlue)
//                    .shadow(radius: 50)
//                Spacer()
//                
//                Image(systemName: volumeIconName(volume: volume))
//                    .foregroundColor(.gray)
//                    
//            }
//            .frame(width: 100, height: 300)
//            .padding()
//        }
//        .edgesIgnoringSafeArea(.all)
    }
    func volumeIconName(volume: Double) -> String {
        switch volume {
        case 0:
            return "volume.slash.fill"
        case 0..<0.33:
            return "volume.1.fill"
        case 0.33..<0.66:
            return "volume.2.fill"
        case 0.66...1:
            return "volume.3.fill"
        default:
            return "volume.fill"
        }
    }
}




#Preview {
    VolumeSliderView(value: 1.0, horizontal: false, mute: false, volume: 0.3)
}
