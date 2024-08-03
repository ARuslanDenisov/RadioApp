//
//  ContentView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI
import AVFoundation

struct RootView: View {
    @StateObject var dataViewModel = DataViewModel()
    @State var index = 0
    
    var body: some View {
        
        ZStack {
            Color.raDarkBlue
                .ignoresSafeArea()
            NavigationView {
                switch index {
                case 0: PopularView(viewModel: dataViewModel)
                case 1: FavoriteView(viewModel: dataViewModel)
                case 2: AllStationView(viewModel: dataViewModel)
                default: PopularView(viewModel: dataViewModel)
                }

            }
            .navigationViewStyle(.stack)
            // authView
            if dataViewModel.showAuthView {
                NavigationView {
                    AuthView(mainViewModel: dataViewModel, showAuthView: $dataViewModel.showAuthView)
                        .opacity(dataViewModel.showAuthView ? 1 : 0)
                }
            }
            //header and tabBar
            if !dataViewModel.showAuthView {
                VStack {
                    //header
                    VStack {
                        HStack(spacing: 0) {
                            Button {  print(dataViewModel.user) } label: {
                                Image("appLogo")
                                    .resizableToFit()
                                    .frame(width: 33)
                                    .padding(.trailing, 7)
                            }
                            Text("Hello, ")
                                .foregroundStyle(.white)
                                .font(.custom(FontApp.bold, size: 30))
                            Text(dataViewModel.user.name)
                                .foregroundStyle(.raPink)
                                .font(.custom(FontApp.bold, size: 30))
                            Spacer()
                            NavigationLink {
                                ProfileView(viewModel: dataViewModel)
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundStyle(.white)
                                    Image(uiImage: dataViewModel.userPhoto)
                                        .resizableToFit()
                                }
                                .clipShape(TriangleShape())
                            }
                            .frame(width: 40,height: 40)
                            
                        }
                        .padding(5)
                        Spacer()
                    }
//                    RadioButtonsView(play: $dataViewModel.play, next: $dataViewModel.next, prev: $dataViewModel.prev)
                        .padding(10)
                    //tabbar
                    TabBarView(selectedTab: $index)
                }
                .opacity(dataViewModel.showAuthView ? 0 : 1)
            }
        }
        //animation
        
        .animation(.easeInOut(duration: 1), value: index)
        .animation(.easeInOut(duration: 0.5), value: dataViewModel.user.name)
        .animation(.easeInOut(duration: 1), value: dataViewModel.showAuthView)
        
        .onAppear {
            
        }
    }

}

#Preview {
    NavigationView {
        RootView()
    }
}
