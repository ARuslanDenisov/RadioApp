//
//  AllStationView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct AllStationView: View {

    var viewModel: DataViewModel
    var stationModel: [StationModel] = []
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
                        ForEach(stationModel, id: \.id) { station in
                            RadioBigAllStationElement(station: station, playingNow: true)
                        }
                    }
                }
                .frame(width: 300, height: 380)
                Spacer()
            }
            
        }
    }
}

#Preview {
    AllStationView(viewModel: DataViewModel(), stationModel: [StationModel(id: "0", name: "Radio Record", favicon: "", streamUrl: "", tags: "", language: "", countryCode: "", votes: 100)])
}

