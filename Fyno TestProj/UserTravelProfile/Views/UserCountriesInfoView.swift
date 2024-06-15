//
//  UserCountriesInfoView.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import SwiftUI
import SwiftData

struct UserCountriesInfoView: View {
    
    @Query private var userProfile: [UserProfile]
    @Query private var allCountries: [Country]
//    @Query private var visitedCountries: [Country]
    
    private var userBeenCountrCount: Int {
        userProfile.first?.haveBeenCountriesName.count ?? 0
    }
    
    init() {
//        _visitedCountries = Query(filter: #Predicate<Country> { country in
//            guard let userProfile = userProfile.first else { return false }
//            
//            return userProfile.allCountriesName.contains(country.countryName)
//        }, sort: \Country.countryName)
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Text(userBeenCountrCount.description)
                    .font(.system(size: 22, weight: .semibold, design: .default))
                    .lineSpacing(28 - 22)
                    .kerning(0.35)
                    .multilineTextAlignment(.leading)
                
                Text("countr" + (userBeenCountrCount > 1 ? "ies" : "y"))
                    .font(.system(size: 15, weight: .regular, design: .default))
                    .lineSpacing(21 - 15)
                    .kerning(-0.20)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.8))
            }
            
            Spacer()
            
            Divider()
                .frame(width: 1.0, height: 33.0)
            
            Spacer()
            
            VStack {
                setupPercentageView()
                    .font(.system(size: 22, weight: .semibold, design: .default))
                    .lineSpacing(28 - 22)
                    .kerning(0.35)
                    .multilineTextAlignment(.leading)
                
                Text("world")
                    .font(.system(size: 15, weight: .regular, design: .default))
                    .lineSpacing(21 - 15)
                    .kerning(-0.20)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.8))
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 94.0)
    }
    
    func setupPercentageView() -> some View {
        let percentage = (Double(userBeenCountrCount) / Double(allCountries.count)) * 100
        let formattedPercentage = String(format: "%.f%%", percentage)
        
        return Text(formattedPercentage)
    }
    
}
