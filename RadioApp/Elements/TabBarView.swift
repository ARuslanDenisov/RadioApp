//
//  TabBarView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
          Spacer()
            // tab Popular View
                VStack {
                    Text("Popular")
                        .font(.custom(FontApp.regular, size: 20))
                        .foregroundStyle(selectedTab == 0 ? .white : .gray)
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(selectedTab == 0 ? .raLightBlue : .clear)
                }
                .onTapGesture {
                    selectedTab = 0
                }
            Spacer()
            // tab Favorites View
                VStack {
                    Text("Favorites")
                        .font(.custom(FontApp.regular, size: 20))
                        .foregroundStyle(selectedTab == 1 ? .white : .gray)
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(selectedTab == 1 ? .raLightBlue : .clear)
                }
                .onTapGesture {
                    selectedTab = 1
                }
            Spacer()
            // tab AllStaions View
                VStack {
                    Text("AllStations")
                        .font(.custom(FontApp.regular, size: 20))
                        .foregroundStyle(selectedTab == 2 ? .white : .gray)
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(selectedTab == 2 ? .raLightBlue : .clear)
                }
                .onTapGesture {
                    selectedTab = 2
                }
            Spacer()
        }
        .background(Color("RADarkBlue"))
        .animation(.easeInOut, value: selectedTab)
    }
}

#Preview {
    TabBarView(selectedTab: .constant(1))
}
