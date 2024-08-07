//
//  OnboardingPage.swift
//  RadioApp
//
//  Created by Юрий on 07.08.2024.
//

import SwiftUI

struct OnboardingStep {
    let image: String
    let title: String
    let description: String
}

struct OnboardingView: View {
    @State private var currentSteps = 0
    @Binding var showOnbording: Bool
    @Environment (\.dismiss) var dismiss
    
    private let onboardingSteps = [
        OnboardingStep(image: "backgroundOnbording", title: "Get Started", description: "Enjoy the best radio station \n from you home, don't miss \n out on anything"),
        OnboardingStep(image: "Onboarding2", title: "Transition", description: "Long press and you fail to view"),
        OnboardingStep(image: "Onboarding3", title: "Favorites", description: "Add to your favorites - click on the heart")

    ]
    
    var body: some View {
        ZStack {
            TabView(selection: $currentSteps) {
                ForEach(onboardingSteps.indices) { item in
                    ZStack {
                        Image(onboardingSteps[item].image)
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFill()
                            .scaleEffect(item == 0 ? 1.05 : 1)
                        VStack {
                            Spacer()
                            ZStack {
                                Rectangle().frame(height: 450)
                                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.clear, .raDarkBlue]), startPoint: .top, endPoint: .bottom))
                                
                                VStack {
                                    Text(onboardingSteps[item].title)
                                        .font(.custom(FontApp.bold, size: 30))
                                        .foregroundStyle(.white)
                                    
                                    Text(onboardingSteps[item].description)
                                        .font(.custom(FontApp.regular, size: 20))
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                    }
//                    .tag(item)
                }
            }
            .ignoresSafeArea()
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut)
            .transition(.slide)
            
            VStack {
                Spacer()
                HStack {
                    ForEach(onboardingSteps.indices) { item in
                        if item == currentSteps {
                            Rectangle()
                                .frame(width: 20, height: 10)
                                .cornerRadius(10)
                                .foregroundColor(.raMediumBlue)
                        } else {
                            Circle()
                                .frame(height: 10)
                                .foregroundStyle(.raLightGray)
                        }
                    }
                }
                
                Button {
                    if self.currentSteps < onboardingSteps.count - 1 {
                        self.currentSteps += 1
                    } else {
                        showOnbording = false
                        dismiss()
                    }
                } label: {
                    Text(currentSteps < onboardingSteps.count - 1 ? "Next" : "Get Started")
                        .font(.custom(FontApp.bold, size: 20))
                        .foregroundStyle(.white)
                        .frame(height: 58)
                        .frame(maxWidth: .infinity)
                        .background(.raPink)
                        .cornerRadius(15)
                        .padding(.bottom, 7)
                }
                .padding()
                .buttonStyle(PlainButtonStyle())
                .animation(.easeInOut, value: currentSteps )
            }
        }
    }
}

#Preview {
    OnboardingView(showOnbording: .constant(false))
}

