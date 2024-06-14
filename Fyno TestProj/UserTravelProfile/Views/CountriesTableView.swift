//
//  CountriesTableView.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import SwiftUI
import SwiftData

enum CountriesTableViewType {
    
    case haveBeen
    case wantBe
    
}

struct CountriesTableView: View {
    
    /*@Query*/ private var allCountries: [Country] = Country.testCountries
    /*@Query*/ private var userProfile: [UserProfile] = [.testUser]
    
//    let viewType: CountriesTableViewType
    
    var body: some View {
        VStack(alignment: .center, spacing: 0.0) {
            Divider()
            
            HStack {
                Text("I’ve been to")
                    .font(.system(size: 17, weight: .semibold, design: .default))
                    .lineSpacing(24 - 17)
                    .kerning(-0.408)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack(alignment: .center, spacing: 0.0) {
                        Image("plus_icon")
                            .resizable()
                            .frame(width: 32.0, height: 32.0, alignment: .center)
                        
                        Text("Add country")
                            .font(.system(size: 15, weight: .semibold, design: .default))
                            .lineSpacing(32 - 15) // Line height minus font size
                            .kerning(-0.1)
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(Color(red: 88 / 255, green: 86 / 255, blue: 214 / 255))
                            .padding(.trailing, 8.0)
                    }
                    .padding(.horizontal, 8.0)
                    .background {
                        RoundedRectangle(cornerRadius: 40.0)
                            .foregroundStyle(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
                    }
                }.frame(height: 32.0, alignment: .center)
                
            }
            .padding(.top, 16.0)
            
            List {
                ForEach(allCountries.filter { userProfile.first!.allCountriesName.contains($0.countryName)}) { country in
                    CountryRow(country: country)
                        .frame(height: 48.0)
                        .listRowSeparator(.hidden)
                }
                .background(Color.clear)
            }
            .listStyle(PlainListStyle())
            .scrollDisabled(true)
            .scrollIndicators(.hidden)
            
            Spacer()
        }
        .frame(height: 256.0)
        .padding(.horizontal, 24.0)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Schema([
            Country.self,
            UserProfile.self
        ]), configurations: config)
        
        return CountriesTableView()
            .onAppear {
                container.mainContext.insert(UserProfile.testUser)
                LoadCountriesModel.shared.loadAndSaveCountries(context: container.mainContext)
            }
            .modelContainer(container)
    } catch {
        return Text("")
    }
}
