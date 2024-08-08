//
//  VolumeSliderView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct VolumeSliderView: View {
    @ObservedObject var radioPlayer: RadioPlayer = .shared
    @State private var lastCoordinateValue: CGFloat = 0.0
    @State private var oldValue: CGFloat = 0.0
    @State var horizontal: Bool
    @State var mute: Bool

    private let minValue: Double = 0.0
    private let maxValue: Double = 190.0

    var body: some View {
        GeometryReader { geometry in
            let sliderWidth: CGFloat = horizontal ? 190 : 2
            let sliderHeight: CGFloat = horizontal ? 2 : 190

            VStack {
                if horizontal {
                    HStack {
                        Image(systemName: volumeIconName(volume: radioPlayer.volume))
                            .foregroundColor(.gray)
                            .frame(width: 20, height: 20)
                            .onTapGesture {
                                toggleMute()
                            }
                            .padding(.trailing, 10)

                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: sliderWidth, height: sliderHeight)
                                .foregroundColor(Color.gray.opacity(0.2))

                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: CGFloat(Double(radioPlayer.volume) * maxValue), height: sliderHeight)
                                .foregroundColor(.raLightBlue)

                            Circle()
                                .foregroundColor(.raLightBlue)
                                .frame(width: 15, height: 15)
                                .offset(x: CGFloat(Double(radioPlayer.volume) * maxValue - 15).clamped(to: 0...maxValue))
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { v in
                                            let newValue = (lastCoordinateValue + v.translation.width).clamped(to: minValue...maxValue)
                                            radioPlayer.setVolume(Float(newValue / maxValue))
                                        }
                                        .onEnded { v in
                                            lastCoordinateValue = CGFloat(Double(radioPlayer.volume) * maxValue)
                                        }
                                )
                        }
                        .frame(width: sliderWidth)

                        Text(volumeText(volume: Double(radioPlayer.volume) * maxValue))
                            .foregroundColor(.white)
                            .font(.custom(FontApp.regular, size: 18))
                            .frame(width: 60)
                            .padding(.leading, 5)
                    }
                } else {
                    VStack {
                        Text(volumeText(volume: Double(radioPlayer.volume) * maxValue))
                            .foregroundColor(.white)
                            .font(.custom(FontApp.regular, size: 18))
                            .frame(width: 60)
                            .padding(.bottom, 5)

                        ZStack(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: sliderWidth, height: sliderHeight)
                                .foregroundColor(Color.gray.opacity(0.2))

                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: sliderWidth, height: CGFloat(Double(radioPlayer.volume) * maxValue))
                                .foregroundColor(.raLightBlue)

                            Circle()
                                .foregroundColor(.raLightBlue)
                                .frame(width: 15, height: 15)
                                .offset(y: -(CGFloat(Double(radioPlayer.volume) * maxValue).clamped(to: 0...maxValue)))
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { v in
                                            let newValue = (lastCoordinateValue - v.translation.height).clamped(to: minValue...maxValue)
                                            radioPlayer.setVolume(Float(newValue / maxValue))
                                        }
                                        .onEnded { v in
                                            lastCoordinateValue = CGFloat(Double(radioPlayer.volume) * maxValue)
                                        }
                                )
                        }
                        .frame(height: sliderHeight)

                        Image(systemName: volumeIconName(volume: radioPlayer.volume))
                            .foregroundColor(.gray)
                            .frame(width: 20, height: 20)
                            .onTapGesture {
                                toggleMute()
                            }
                            .padding(.top, 10)
                    }
                }
            }
        }
        .onAppear {
            lastCoordinateValue = CGFloat(Double(radioPlayer.volume) * maxValue)
        }
        .animation(.linear(duration: 0.1), value: radioPlayer.volume)
    }

    private func toggleMute() {
        if radioPlayer.volume != 0.0 {
            oldValue = CGFloat(Double(radioPlayer.volume) * maxValue)
            radioPlayer.setVolume(0.0)
            mute = true
        } else {
            radioPlayer.setVolume(Float(oldValue / maxValue))
            mute = false
        }
    }

    private func volumeIconName(volume: Float) -> String {
        switch volume {
        case 0:
            return "volume.slash.fill"
        case 0..<0.333:
            return "volume.1.fill"
        case 0.333..<0.667:
            return "volume.2.fill"
        case 0.667...1:
            return "volume.3.fill"
        default:
            return "volume.fill"
        }
    }

    private func volumeText(volume: Double) -> String {
        "\(volume != maxValue ? Int(volume / maxValue * 100) : 100 )%"
    }
}

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        return min(max(self, range.lowerBound), range.upperBound)
    }
}

#Preview {
    VolumeSliderView(horizontal: false, mute: false)
}
