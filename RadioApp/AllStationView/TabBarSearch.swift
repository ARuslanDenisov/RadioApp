//
//  TabBarSearch.swift
//  RadioApp
//
//  Created by Руслан on 06.08.2024.
//

import SwiftUI

struct TabBarSearch: View {
    @Binding var index: Int
    let tabArray = ["Popular", "Favorites", "All Stations"]
    var body: some View {
            HStack {
                HStack {
                    ForEach( tabArray.indices) { index in
                        HStack {
                            Circle()
                                .frame(width: 10)
                                .foregroundStyle(.raLightBlue)
                                .opacity(index == self.index ? 1 : 0)
                            Text(tabArray[index])
                                .foregroundStyle(index == self.index ? .white : .raLightGray)
                                .font(.custom(FontApp.bold, size: 16))
                                
                        }
                        .frame(width: 120)
                        .padding(.horizontal, 10)
                        .onTapGesture {
                            self.index = index
                        }
                    }
                }
                .frame(height: 20)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: index)
            }
    }
}

#Preview {
    TabBarSearch(index: .constant(2))
}
