//
//  FavoriteView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject var viewModel: DataViewModel
    var body: some View {
        ZStack{
            Color.raDarkBlue
                .ignoresSafeArea()
            //Header
            VStack {
                HStack(spacing: 0) {
                    Image("appLogo")
                        .resizableToFit()
                        .frame(width: 33)
                        .padding(.trailing, 7)
                    Text("Hello, ")
                        .foregroundStyle(.white)
                        .font(.custom(FontApp.bold, size: 30))
                    Text(viewModel.user.name.isEmpty ? "New user" : viewModel.user.name)
                        .foregroundStyle(.raPink)
                        .font(.custom(FontApp.bold, size: 30))
                    Spacer()
                    NavigationLink {
                        ProfileView()
                    } label: {
                        //тут будет картинка пользователя
                        Image("")
                            .resizableToFit()
                        ZStack {
                            Rectangle()
                                .foregroundStyle(.white)
                        }
                        .clipShape(TriangleShape().offset(x:-20, y: 15))
                        
                        
                    }
                    .frame(width: 30,height: 30)
                    
                }
                .padding(5)
                Spacer()
            }
            //favorites with scroll view
            VStack(alignment: .leading, spacing: 0) {
                Text("Favorites")
                    .foregroundStyle(.white)
                    .font(.custom(FontApp.regular, size: 30))
                    .padding(.top, 100)
                ScrollView {
                    ForEach(viewModel.user.favorites) { station in
                        NavigationLink {
                            
                        } label: {
                            RadioBigFavoriteElement(station: station, animationStart: true)
                        }
                        
                    }
                }
                .padding(.top, 20)
                .frame(width: 300, height: 380  )
                Spacer()
            }
            
            
        }
    }
}

#Preview {
    NavigationView {
        FavoriteView(viewModel: DataViewModel(user: UserModel(id: "", name: "Artem", email: "", photoUrl: "", favorites: [StationModel(id: "12312312", name: "Radio da4a", favicon: "", streamUrl: "", tags: "Popular", language: "English", countryCode: "RU", votes: 35)]), stationNow: StationModel()))
    }
}


