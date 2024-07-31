//
//  OnboardingView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // background
            Image("backgroundOnbording")
                .resizableToFill()
                .ignoresSafeArea()
            // text
            VStack(alignment: .leading, spacing: 0) {
                Text("Let's Get \nStarted")
                    .font(.custom(FontApp.bold, size: 60))
                    .padding(.top, 150)
                .foregroundStyle(.white)
                Text("Enjoy the best radio station \n from you home, don't miss \n out on anything")
                    .foregroundStyle(.white)
                    .font(.custom(FontApp.regular, size: 16))
                    .padding(.top, 31)
                Spacer()
                // button
                Button {
                    dismiss()
                } label: {
                    Text("Get Started")
                        .foregroundStyle(.white)
                        .frame(height: 58)
                        .frame(maxWidth: .infinity)
                        .background(.raPink)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.bottom, 75)
                    
                }
            }
            .padding(.horizontal, 52)
        }
    }
}

#Preview {
    OnboardingView()
}
