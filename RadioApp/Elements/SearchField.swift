//
//  SearchField.swift
//  RadioApp
//
//  Created by Юрий on 01.08.2024.
//

import SwiftUI

struct SearchField: View {
    @Binding var searchRadio: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(height: 44)
                .foregroundStyle(.raSearch)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.white)
                    .padding()
                TextField("", text: $searchRadio)
                    .foregroundStyle(.white)
                    .placeholder(when: searchRadio.isEmpty) {
                      Text("Search radio station".localized)
                            .foregroundStyle(.white)
                            .font(.custom(FontApp.regular, size: 14))
                    }
                
            }
        }
    }
}

