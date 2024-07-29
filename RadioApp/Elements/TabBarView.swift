//
//  TabBarView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        HStack {
            Spacer()
            // tab Popular View
            Button {
                self.selectedTab = 0
            } label: {
                VStack {
                    Text("Popular")
                        .font(.system(size: 20))
                        .foregroundStyle(selectedTab == 0 ? .white : .gray)
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(selectedTab == 0 ? .raLightBlue : .clear)
                }
            }
            Spacer()
            // tab Favorites View
            Button {
                self.selectedTab = 1
            } label: {
                VStack {
                    Text("Favorites")
                        .font(.system(size: 20))
                        .foregroundStyle(selectedTab == 1 ? .white : .gray)
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(selectedTab == 1 ? .raLightBlue : .clear)
                }
            }
            Spacer()
            // tab AllStaions View
            Button {
                self.selectedTab = 2
            } label: {
                VStack {
                    Text("AllStations")
                        .font(.system(size: 20))
                        .foregroundStyle(selectedTab == 2 ? .white : .gray)
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(selectedTab == 2 ? .raLightBlue : .clear)
                }
            }
            Spacer()
        }
        .background(Color("RADarkBlue"))
    }
}

#Preview {
    TabBarView()
}
