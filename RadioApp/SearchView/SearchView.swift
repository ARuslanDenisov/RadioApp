//
//  SearchView.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchSetup: SearchType
    @EnvironmentObject var languageManager: LanguageManager
    @State var firstSetup = false
    @State var secondSetup = false
    @Binding var searchTag: String
    @Binding var searchSet: Bool
    @State var closure: () -> ()
    let arrayOfOptions = ["tags", "language", "country"]
    @State var arrayOfTags = [""]
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
//            Color(.raDarkBlue)
//                .frame(width: 350, height: 390)
            if !firstSetup {
                VStack {
                    ForEach(SearchType.allCases, id: \.self ) { option in
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 0.8)
                                .foregroundStyle(.raLightGray)
                            HStack{
                              Text("Browse by \n%s".localized(with: option.rawValue))
                                    .font(.custom(FontApp.bold, size: 30))
                                    .foregroundStyle(.white)
                                    .padding()
                                    
                                Spacer()
                            }
                        }
                        .onTapGesture {
                            firstSetup = true
                            searchSetup = option
                            arrayOfTags = getArray()
                        }
                        .frame(width: 291, height: 123)
                        
                        
                    }
                }
            } else {
                ScrollView (showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 139))], spacing: 15) {
                        ForEach(arrayOfTags, id: \.self) { tag in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 0.8)
                                    .foregroundStyle(.raLightGray)
                                    
                              Text(tag.localized)
                                    .font(.custom(FontApp.bold, size: 20))
                                    .foregroundStyle(.white)
                                    .padding()
                                    .multilineTextAlignment(.center)
                                
                                
                            }
                            .frame(width: 135, height: 120)
                            .onTapGesture {
                                searchTag = tag
                                closure()
                                searchSet = true
                            }
                        }
                        
                    }
                    .frame(width: 300)
                }
            }
        }
        .frame(width: 350, height: 390)
    }
    
    func getArray () -> [String] {
        switch searchSetup {
        case .tags : return RadioTags.allCases.map{ $0.rawValue }
        case .language : return Languages.allCases.map{ $0.rawValue }
        case .country : return Country.allCases.map{ $0.rawValue }
        }
    }
}

#Preview {
    SearchView(searchSetup: .constant(SearchType.tags), searchTag: .constant(""), searchSet: .constant(true), closure: { print("text")
    })
}
