//
//  VolumeSliderView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct VolumeSliderView: View {
    @State var value: Double
    @State private var lastCoordinateValue: CGFloat = 0.0
    @State private var oldValue = 0.0
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
                        Image(systemName: volumeIconName(volume: value))
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
                                .frame(width: CGFloat(value), height: sliderHeight)
                                .foregroundColor(.raLightBlue)

                            Circle()
                                .foregroundColor(.raLightBlue)
                                .frame(width: 15, height: 15)
                                .offset(x: (value - 15).clamped(to: 0...maxValue))
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { v in
                                            let newValue = (lastCoordinateValue + v.translation.width).clamped(to: minValue...maxValue)
                                            value = newValue
                                            RadioPlayer.shared.setVolume(Float(value / maxValue))
                                        }
                                        .onEnded { v in
                                            lastCoordinateValue = value
                                        }
                                )
                        }
                        .frame(width: sliderWidth)

                        Text(volumeText(volume: value))
                            .foregroundColor(.white)
                            .font(.custom(FontApp.regular, size: 18))
                            .frame(width: 60)
                            .padding(.leading, 5)
                    }
                } else {
                    VStack {
                        Text(volumeText(volume: value))
                            .foregroundColor(.white)
                            .font(.custom(FontApp.regular, size: 18))
                            .frame(width: 60)
                            .padding(.bottom, 5)

                        ZStack(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: sliderWidth, height: sliderHeight)
                                .foregroundColor(Color.gray.opacity(0.2))

                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: sliderWidth, height: CGFloat(value))
                                .foregroundColor(.raLightBlue)

                            Circle()
                                .foregroundColor(.raLightBlue)
                                .frame(width: 15, height: 15)
                                .offset(y: -(CGFloat(value).clamped(to: 0...maxValue)))
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { v in
                                            let newValue = (lastCoordinateValue - v.translation.height).clamped(to: minValue...maxValue)
                                            value = newValue
                                            RadioPlayer.shared.setVolume(Float(value / maxValue))
                                        }
                                        .onEnded { v in
                                            lastCoordinateValue = value
                                        }
                                )
                        }
                        .frame(height: sliderHeight)

                        Image(systemName: volumeIconName(volume: value))
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
        .animation(.linear(duration: 0.1), value: value)
    }

    private func toggleMute() {
        if value != 0.0  {
            oldValue = value
            value = 0.0
            mute = true
        } else {
            value = oldValue
            mute = false
        }
        RadioPlayer.shared.setVolume(Float(value / maxValue))
    }

    private func volumeIconName(volume: Double) -> String {
        switch volume {
        case 0:
            return "volume.slash.fill"
        case 0..<63.3:
            return "volume.1.fill"
        case 63.3..<127.6:
            return "volume.2.fill"
        case 127.6...maxValue:
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
    VolumeSliderView(value: 1.0, horizontal: false, mute: false)
}
