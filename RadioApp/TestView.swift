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
        ZStack {
            Text("Some very very very very very very veryv eryvveyvyeey long text")
                .lineLimit(1)
                .frame(width: 900)
              .offset(x: animation ? -CGFloat(rad2.count * 4) : CGFloat(rad2.count * 4) )
              .animation(Animation.linear(duration: 8).repeatForever(autoreverses: true))
              .onAppear {
                self.animation.toggle()
              }
        }
        .frame(width: 200)
        .clipShape(Rectangle())
            
        
        .frame(width: 200)
        Button {
            animation.toggle()
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
