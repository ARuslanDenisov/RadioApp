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
    @State var rad2 = false
    @State var animation = false
    var body: some View {
//        ZStack {
//            HStack {
//                Spacer()
//                VStack {
//                    Spacer()
//                    ZStack {
//                        TriangleShape()
//                            .frame(width: 40, height: 40)
//
//                        sixAngleShape()
//                            .stroke(lineWidth: 1)
//                            .foregroundStyle(.raPink)
//                            .frame(width: 60, height: 60)
//                            .scaleEffect(CGFloat(!rad ? 0.3 : 1.5), anchor: .center)
//                            .opacity(!rad ? 1.0 : 0.0)
//                            .shadow(radius: 10)
//                        sixAngleShape()
//                            .frame(width: 60, height: 60)
//                            .scaleEffect(rad2 ? 1.0 : 1.1 )
//                            .foregroundStyle(.raPink)
//                    }
//                    Spacer()
//                    
//                }
//                Spacer()
//            }
//            .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: false), value: rad)
//            .animation(.easeInOut.repeatForever(autoreverses: true), value: rad2)
//        }
//        Button {
//            rad.toggle()
//            rad2.toggle()
//        } label: {
//            Text("perss me")
//        }
        VStack {
            
            Button("Notification") {
                NotificationManager.instance.requestAutorzation()
            }
            Button("Schedule Notification") {
                NotificationManager.instance.sheduleNotification()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
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
