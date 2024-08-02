//
//  AllStationView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct AllStationView: View {

    @StateObject var viewModel: DataViewModel
    @State var searchRadio: String = ""
    
    var body: some View {
        ZStack {
            Color.raDarkBlue
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("All Stations")
                            .foregroundStyle(.white)
                            .font(.custom(FontApp.regular, size: 30))
                        .padding(.top, 80)
                        .padding(.leading, 50)
                    Spacer()
                }
                
                
                SearchField(searchRadio: $searchRadio)
                    .padding(.horizontal, 10)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(viewModel.allStation, id: \.id) { station in
//                            RadioBigAllStationElement(station: station, playingNow: true)
                            if viewModel.stationNow.id == station.id {
                                RadioBigAllStationElement(station: station, playingNow: true)
                                    .shadow(color: .raPink.opacity(0.7), radius: 10)
                                    .onTapGesture {
                                        viewModel.stationNow = station
                                        print(viewModel.stationNow)
                                    }
                            } else {
                                RadioBigAllStationElement(station: station, playingNow: false)
                                    .onTapGesture {
                                        viewModel.stationNow = station
                                        print(viewModel.stationNow)
                                    }
                            }
                                
                        }
                    }
                    .animation(.easeInOut, value: viewModel.stationNow.id)
                }
//                .frame(width: 300, height: 380)
                Spacer()
            }
            
        }
    }
}

#Preview {
    AllStationView(viewModel: DataViewModel())
}

