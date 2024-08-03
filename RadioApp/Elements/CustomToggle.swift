//
//  CustomToggle.swift
//  RadioApp
//
//  Created by Юрий on 02.08.2024.
//

import SwiftUI

struct CustomToggle: ToggleStyle {
    var onColor: Color
       var offColor: Color
       var thumbColor: Color

       func makeBody(configuration: Self.Configuration) -> some View {
           HStack {
               configuration.label
                   .font(.body)
               Spacer()
               RoundedRectangle(cornerRadius: 16, style: .circular)
                   .fill(configuration.isOn ? onColor : offColor)
                   .frame(width: 50, height: 30)
                   .overlay(
                       Circle()
                           .fill(thumbColor)
                           .padding(2)
                           .offset(x: configuration.isOn ? 10 : -10)
                   )
                   .onTapGesture {
                       withAnimation(.smooth(duration: 0.2)) {
                           configuration.isOn.toggle()
                       }
                   }
           }
       }
   }

