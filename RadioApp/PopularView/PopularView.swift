//
//  PopularView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct PopularView: View {
    @StateObject var viewModel: DataViewModel
    var body: some View {
        ZStack {
            Text("PopularView")
        }
    }
}

#Preview {
    PopularView(viewModel: DataViewModel())
}

