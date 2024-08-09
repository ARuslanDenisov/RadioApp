//
//  ContentView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI
import AVFoundation

struct RootView: View {
    @StateObject var viewModel = DataViewModel()
    @StateObject var authViewModel = AuthViewModel()
    @EnvironmentObject var languageManager: LanguageManager

    var body: some View {
        ZStack {
            Color.raDarkBlue
                .ignoresSafeArea()
            NavigationView {
                switch viewModel.tabBarIndex {
                case 0:
                    PopularView(viewModel: viewModel)
                        .environmentObject(languageManager)
                case 1:
                    FavoriteView(viewModel: viewModel)
                        .environmentObject(languageManager)
                case 2:
                    AllStationView(viewModel: viewModel)
                        .environmentObject(languageManager)
                default:
                    PopularView(viewModel: viewModel)
                        .environmentObject(languageManager)
                }
            }
            .navigationViewStyle(.stack)

            if viewModel.showAuthView {
                NavigationView {
                    AuthView(mainViewModel: viewModel, showAuthView: $viewModel.showAuthView)
                        .environmentObject(languageManager)
                }
            }

            if !viewModel.showAuthView {
                VStack {
                    Spacer()
                    EllipticalGradient(colors: [Color.raDarkBlue, Color.clear], center: .bottom, startRadiusFraction: 0.7, endRadiusFraction: 0.9)
                        .frame(height: 150)
                        .padding(.bottom, 20)
                        .opacity(viewModel.showTabBar ? 1: 0)
                }
                VStack {
                    VStack {
                        HStack(spacing: 0) {
                            Button { print(viewModel.user) } label: {
                                Image("appLogo")
                                    .resizableToFit()
                                    .frame(width: 33)
                                    .padding(.trailing, 7)
                            }
                            Text("Hello, ".localized)
                                .foregroundStyle(.white)
                                .font(.custom(FontApp.bold, size: 30))
                            Text(viewModel.user.name)
                                .foregroundStyle(.raPink)
                                .font(.custom(FontApp.bold, size: 30))
                            Spacer()
                            NavigationLink {
                                ProfileView(viewModel: viewModel, authViewModel: authViewModel)
                                    .environmentObject(languageManager)
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundStyle(.white)
                                    Image(uiImage: viewModel.userPhoto)
                                        .resizableToFit()
                                }
                                .clipShape(TriangleShape())
                            }
                            .frame(width: 40, height: 40)
                        }
                        .padding(5)
                        Spacer()
                    }
                    ZStack {
                        if viewModel.play {
                            TabBarAnimation(animation: true)
                                .frame(height: 100)
                                .scaleEffect(1.4)
                        }
                        RadioButtonsView(viewModel: viewModel)
                    }
                    .offset(x: viewModel.showTabBar ? 0 : 50)

                    TabBarView(selectedTab: $viewModel.tabBarIndex)
                        .offset(y: viewModel.showTabBar ? 0 : 200)
                }
                .opacity(viewModel.showAuthView ? 0 : 1)
            }
            if viewModel.showOnboarding {
                OnboardingView(showOnbording: $viewModel.showOnboarding)
                    .environmentObject(languageManager)
            }
        }
        .fullScreenCover(isPresented: $viewModel.showDetailView, content: {
            NavigationView {
                StationDetailView(viewModel: viewModel)
                    .environmentObject(languageManager)
            }
        })
        .animation(.easeInOut(duration: 1), value: viewModel.tabBarIndex)
        .animation(.easeInOut(duration: 0.5), value: viewModel.user.name)
        .animation(.easeInOut(duration: 1), value: viewModel.showAuthView)
        .animation(.easeInOut, value: viewModel.play)
        .animation(.easeInOut, value: viewModel.showTabBar)
        .onAppear {
            // Perform necessary actions on appear
        }
    }
}

#Preview {
    NavigationView {
        RootView()
            .environmentObject(LanguageManager())
    }
}
