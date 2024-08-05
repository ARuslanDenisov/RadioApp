//
//  VolumeSliderView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct VolumeSliderView: View {
    //TODO: Volume 
    @State var value: Double
    @State private var lastCoordinateValue: CGFloat = 0.0
    @State private var oldValue = 0.0
    @State var horizontal : Bool
    @State var mute: Bool
    var body: some View {
        GeometryReader { gr in
            let radius = 0.01
            let minValue = 0.0
            let maxValue = 190.0
            if horizontal {
                HStack {
                    Spacer()
                    // image
                    Image(systemName: volumeIconName(volume: value))
                        .foregroundColor(.gray)
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            if value != 0.0  {
                                oldValue = value
                                value = 0.0
                                mute = true
                            } else {
                                value = oldValue
                                mute = false
                            }
                            
                        }
                        .padding(.trailing, 19)
                    // slider
                    ZStack {
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 190, height: 2)
                            Spacer()
                        }
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.raLightBlue)
                                .frame(width: value, height: 2, alignment: .leading)
                            Spacer()
                        }
                        HStack {
                            Circle()
                                .foregroundColor(Color.raLightBlue)
                                .frame(width: 15, height: 15)
                                .offset(x: self.value < 16 ? 0 : self.value-15)
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
                    .frame(width: 190)
                    // text
                    
                    Text(volumeText(volume:value))
                        .foregroundColor(.white)
                        .font(.custom(FontApp.regular, size: 18))
                        .frame(width: 60)
                        .padding(.leading, 5)
                    Spacer()
                }
            } else {
                VStack {
                    Spacer()
                    // text
                    Text(volumeText(volume:value))
                        .foregroundColor(.white)
                        .font(.custom(FontApp.regular, size: 18))
                        .frame(width: 60)
                        .padding(.bottom, 5)
                    
                    // slider
                    ZStack {
                        VStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 2, height: 190)
                        }
                        VStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.raLightBlue)
                                .frame(width: 2, height: value, alignment: .leading)
                        }
                        VStack {
                            Spacer()
                            Circle()
                                .foregroundColor(Color.raLightBlue)
                                .frame(width: 15, height: 15)
//                                .offset(y: -self.value > -190 ? -190 : -self.value + 15)
                                .offset(y: self.value-190)
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { v in
                                            if (abs(v.translation.height) < 0.1) {
                                                self.lastCoordinateValue = self.value
                                            }
                                            if v.translation.height > 0 {
                                                self.value = min(maxValue, self.lastCoordinateValue + v.translation.height)
                                            } else {
                                                self.value = max(minValue, self.lastCoordinateValue + v.translation.height)
                                            }
                                            
                                        }
                                )
                            
                        }
                        .rotationEffect(.degrees(180))
                        
                    }
                    .frame(height: 190)
                    // image
                    Image(systemName: volumeIconName(volume: value))
                        .foregroundColor(.gray)
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            if value != 0.0  {
                                oldValue = value
                                value = 0.0
                                mute = true
                            } else {
                                value = oldValue
                                mute = false
                            }
                            
                        }
                        .padding(.top, 19)
                    
                }
            }
            
        }
        .animation(.linear(duration: 0.1), value: value)
    }
    func volumeIconName(volume: Double) -> String {
        switch volume {
        case 0:
            return "volume.slash.fill"
        case 0..<63.3:
            return "volume.1.fill"
        case 63.3..<127.6:
            return "volume.2.fill"
        case 127.6...190:
            return "volume.3.fill"
        default:
            return "volume.fill"
        }
    }
    
    func volumeText(volume: Double) -> String {
        "\(volume != 190.0 ? Int(volume/1.90) : 100 )%"
    }
}




#Preview {
    VolumeSliderView(value: 1.0, horizontal: false, mute: false)
}
