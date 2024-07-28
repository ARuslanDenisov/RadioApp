//
//  TestView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack {
            Button {
                print(URLManager.shared.createURL(uuids: ["1","2", "3"]))
            } label: {
                Text("printMe")
            }
        }
    }
}

#Preview {
    TestView()
}
