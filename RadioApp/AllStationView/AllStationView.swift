//
//  AllStationView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct AllStationView: View {

    var dataVM: DataViewModel
    var stationModel: [StationModel]
    @State var searchRadio: String = ""
    
    var body: some View {
        ZStack {
            Color.raDarkBlue
                .ignoresSafeArea()
            
            VStack {
                    Text("All Stations")
                        .foregroundStyle(.white)
                        .font(.custom(FontApp.regular, size: 30))
                    .padding(.top, 100)
                
                SearchField(searchRadio: $searchRadio)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(stationModel, id: \.id) { station in
                            RadioBigAllStationElement(dataVM: dataVM, playingNow: false)
                        }
                    }
                }
                
            }
            
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    AllStationView(dataVM: DataViewModel(user: UserModel(id: "", name: "Mark", email: "", photoUrl: "", favorites: []), stationNow: StationModel()), stationModel: [StationModel(id: "", name: "Arizona", favicon: "", streamUrl: "", tags: "", language: "", countryCode: "", votes: 1)])
}

struct SearchField: View {
    @Binding var searchRadio: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(height: 44)
                .foregroundStyle(.raMediumBlue)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.white)
                    .padding()
                TextField("Search radio station", text: $searchRadio)
                    .foregroundStyle(.white)
                    .placeholder(when: searchRadio.isEmpty) {
                        Text("Search radio station").foregroundColor(.white)
                    }
                Button {
                    
                } label: {
                    Image(systemName: "chevron.right")
                        .padding(9)
                        .foregroundStyle(.raLightBlue)
                        .background(.black)
                        .clipShape(Circle())
                        .padding()
                }
            }
        }
    }
}
