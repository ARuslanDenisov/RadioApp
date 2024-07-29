//
//  TabBarView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct TabBarView: View {
    // propertis
    @State private var selectedTab: Tab = .popular
    
    // enum category tab bar
    enum Tab {
        case popular
        case favorites
        case allStations
    }
    
    var body: some View {
        // switch view
        VStack {
            switch selectedTab {
            case .popular:
                PopularView()
            case .favorites:
                FavoriteView()
            case .allStations:
                AllStationView()
            }
            // celected tab buttons
            HStack {
                Spacer()
                TabBarButton(nameTab: "Popular", tab: .popular, selectTab: $selectedTab)
                Spacer()
                TabBarButton(nameTab: "Favorites", tab: .favorites, selectTab: $selectedTab)
                Spacer()
                TabBarButton(nameTab: "AllStations", tab: .allStations, selectTab: $selectedTab)
                Spacer()
            }
            .background(Color("RADarkBlue"))
        .ignoresSafeArea()
        }
    }
}

#Preview {
    TabBarView()
}
