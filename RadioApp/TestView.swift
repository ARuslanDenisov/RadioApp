//
//  TestView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI
import Kingfisher

struct TestView: View {
    @State var test: [StationModel] = []
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(test, id: \.id) { value in
                        ZStack {
                            KFImage(URL(string: value.favicon))
                                .resizable()
                                .scaledToFit()
                            Text(value.name)
                                .foregroundStyle(.raPink)
                                .font(.headline)
                        }
                    }
                }
            }
            Button {
                getAll(value: 20)
            } label: {
                Text("printMe")
            }
            Button {
                print(test.count)
            } label: {
                Text("printMe2")
            }
        }
    }
    func getAll (value: Int) {
        Task {
            do {
                test = try await NetworkServiceAA.shared.getAllStations(numberLimit: value)
            } catch {
                print("something bad happend")
            }
            
        }
    }
}

#Preview {
    TestView()
}
