//
//  PopularView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct PopularView: View {
    var body: some View {
        ZStack {
            Color.raDarkBlue
                .ignoresSafeArea()
            Text("Popular view")
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    PopularView()
}
