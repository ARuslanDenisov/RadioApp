//
//  ContentView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct RootView: View {
    @State var showAuthView = true
    @StateObject var dataViewModel = DataViewModel()
    @State var index = 0
    
    var body: some View {
        
        ZStack {
            Color.raDarkBlue
                .ignoresSafeArea()
            NavigationView {
                switch index {
                case 0: PopularView()
                case 1: FavoriteView(viewModel: dataViewModel)
                case 2: AllStationView(stationModel: [StationModel()])
                default: PopularView()
                }

            }
            .navigationViewStyle(.stack)
            
            VStack {
                //header
                VStack {
                    HStack(spacing: 0) {
                        Image("appLogo")
                            .resizableToFit()
                            .frame(width: 33)
                            .padding(.trailing, 7)
                        Text("Hello, ")
                            .foregroundStyle(.white)
                            .font(.custom(FontApp.bold, size: 30))
                        Text(dataViewModel.user.name.isEmpty ? "New user" : dataViewModel.user.name)
                            .foregroundStyle(.raPink)
                            .font(.custom(FontApp.bold, size: 30))
                        Spacer()
                        NavigationLink {
                            ProfileView()
                        } label: {
                            //тут будет картинка пользователя
                            Image("")
                                .resizableToFit()
                            ZStack {
                                Rectangle()
                                    .foregroundStyle(.white)
                            }
                            .clipShape(TriangleShape().offset(x:-20, y: 15))
                            
                            
                        }
                        .frame(width: 30,height: 30)
                        
                    }
                    .padding(5)
                    Spacer()
                }
                //                    .padding(.top, 60)
                Spacer()
                //tabbar
                TabBarView(selectedTab: $index)
            }
            
        }
        //animation
        
        .animation(.easeInOut(duration: 1), value: index)
        
        .onAppear {
            let authUser = try? FBAuthService.shared.getAuthenticationUser()
            self.showAuthView = authUser == nil
        }
        .fullScreenCover(isPresented: $showAuthView, content: {
            NavigationView {
                AuthView(mainViewModel: dataViewModel, showAuthView: $showAuthView)
            }
        })
        
        
    }
}

#Preview {
    NavigationView {
        RootView()
    }
}
