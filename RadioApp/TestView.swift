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
    @State var userIn: UserModel = UserModel()
    @State var userOut: UserModel = UserModel()
    @State var rad = false
    @State var rad2 = "Some very very very very very very veryv eryvveyvyeey long text"
    @State var animation = false
    var body: some View {
            
        
        Button {
            print(URLManager.shared.createURLSearch("rocker", numberLimit: 10)!)
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
