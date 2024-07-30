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
    var body: some View {
        VStack {
                TextField("name", text: $userIn.name)
                .padding()
                .background()
                .shadow(radius: 10)
                .padding(5)
            TextField("email", text: $userIn.email)
            .padding()
            .background()
            .shadow(radius: 10)
            .padding(5)

            VStack{
                Text("name of 2 user: \(userOut.name)")
                Text("email of 2 user: \(userOut.email)")
            }
            Button {
                userIn.id = UUID().uuidString
                saveUser(user:userIn)
            } label: {
                ZStack {
                    Capsule()
                        .frame(width: 100, height: 50)
                    Text("Save me")
                        .foregroundStyle(.white)
                }
            }
            Button {
                Task {
                    let user = try await getUser(userId:userIn.id)
                    DispatchQueue.main.async {
                        userOut = user
                    }
                }
            } label: {
                ZStack {
                    Capsule()
                        .frame(width: 100, height: 50)
                    Text("Get user")
                        .foregroundStyle(.white)
                }
            }
            
            Button {
                Task {
                    do {
                        let ref = try await FBFirestoreService.shared.db.collection("users").addDocument(data: [
                            "first": "Alan",
                            "middle": "Mathison",
                            "last": "Turing",
                            "born": 1912
                        ])
                        print("Document added with ID: \(ref.documentID)")
                    } catch {
                        print("Error adding document: \(error)")
                    }
                }
            } label : {
                Text("testButton")
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
    func saveUser (user: UserModel) {
        Task {
            do {
                try await FBFirestoreService.shared.addNewUser(newUser: user)
            } catch {
                print("eroor with save user")
            }
        }
    }
    func getUser(userId: String) async throws -> UserModel {
                let result = try await FBFirestoreService.shared.getUser(userId: userId)
                return result
        }
    }


#Preview {
    TestView()
}
