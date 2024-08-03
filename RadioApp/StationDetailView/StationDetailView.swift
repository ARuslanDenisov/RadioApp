//
//  StationDetailView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI
import Kingfisher

struct StationDetailView: View {
    @StateObject var viewModel: DataViewModel
    @Environment (\.dismiss) var dismiss
    @State var animation = false
    var body: some View {
        
        ZStack {
            VStack {
                ZStack {
                    // TODO: equalizer!!!!
                    HStack {
                        VStack {
                            Text(viewModel.stationNow.name)
                                .foregroundStyle(.white)
                                .font(.custom(FontApp.bold, size: 40))
                            Text(viewModel.stationNow.tags)
                                .foregroundStyle(.white)
                                .font(.custom(FontApp.regular, size: 20))
                            Spacer()
                        }
                    }
                    HStack {
                        Spacer()
                        VStack {
                            KFImage(URL(string: viewModel.stationNow.favicon))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .rotationEffect(.degrees(viewModel.play ? 0 : 360))
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 10)
                }
                .frame(height: 448)
                Spacer()
//                RadioButtonsView(play: $viewModel.play, next: $viewModel.next, prev: $viewModel.prev)
            }
//            .padding(.bottom, 286)
        }
        .animation(.linear(duration: 3.0).repeatForever(autoreverses: false), value: viewModel.play)
        .background(Image("bg").ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Playing now")
                    .font(.custom(FontApp.semiBold, size: 24))
                    .foregroundColor(.white)
            }
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label : {
                    Image(systemName: "arrow.left")
                        .resizableToFit()
                        .foregroundStyle(.white)
                }
            }
        }
        .onAppear {
            animation.toggle()
        }
    }
}

#Preview {
    NavigationView {
        StationDetailView(viewModel: DataViewModel(user: UserModel(), stationNow: StationModel(id: "", name: "Dacha FM", favicon: "https://www.newstalkzb.co.nz/content/news/images/interface/icons/newstalkzb/apple-touch-icon.png", streamUrl: "", tags: "pop rock", language: "", countryCode: "Ru", votes: 131)))
    }
}
