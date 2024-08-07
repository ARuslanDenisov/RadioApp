//
//  TestView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI
import Kingfisher

struct TestView: View {
    @State var test: [StationModel] = [StationModel(id: "123", name: "", favicon: "", streamUrl: "", tags: "", language: "", countryCode: "", votes: 1)]
    @State var stationNow = StationModel(id: "123", name: "", favicon: "", streamUrl: "", tags: "", language: "", countryCode: "", votes: 1)
    @State var userIn: UserModel = UserModel()
    @State var userOut: UserModel = UserModel()
    @State var rad = false
    @State var rad2 = "Some very very very very very very veryv eryvveyvyeey long text"
    @State var animation = false
    var body: some View {
            
        
        Button {
            let result = test.contains { station in
                station.id == stationNow.id
            }
            print(result)
        } label: {
            Text("perss me")
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
