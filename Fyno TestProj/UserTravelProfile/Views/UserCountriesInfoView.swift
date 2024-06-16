//
//  UserCountriesInfoView.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import SwiftUI
import SwiftData

struct UserCountriesInfoView: View {
    
    // MARK: Properties
    
    @Query private var userProfile: [UserProfile]
    @Query private var allCountries: [Country]
    
    private var userBeenCountrCount: Int {
        userProfile.first?.haveBeenCountriesName.count ?? 0
    }
    
    // MARK: body
    
    var body: some View {
        content
    }
    
}

// MARK: Subviews

private extension UserCountriesInfoView {
    
    var content: some View {
        HStack {
            countryCount
            
            Divider()
                .frame(width: 1.0, height: 33.0)
            
            countryPercentView
        }
        .frame(maxWidth: .infinity)
        .frame(height: 74.0)
    }
    
    var countryCount: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .center, spacing: 0.0) {
                Text(userBeenCountrCount.description)
                    .setupTexTitletMod()
                
                Text("countr" + (userBeenCountrCount > 1 ? "ies" : "y"))
                    .setupTexSubtitletMod()
            }
            
            Spacer()
        }
    }
    
    var countryPercentView: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .center, spacing: 0.0) {
                setupPercentageView()
                    .setupTexTitletMod()
                
                Text("world")
                    .setupTexSubtitletMod()
                
            }
            
            Spacer()
        }
    }
    
}

// MARK: helper methods

private extension UserCountriesInfoView {
    
    func setupPercentageView() -> some View {
        let percentage = (Double(userBeenCountrCount) / Double(allCountries.count)) * 100
        let formattedPercentage = String(format: "%.f%%", percentage)
        
        return Text(formattedPercentage)
    }
    
}

// MARK: View extension (private)

private extension View {
    
    func setupTexTitletMod() -> some View {
        self
            .font(.system(size: 22, weight: .semibold, design: .default))
            .lineSpacing(28 - 22)
            .kerning(0.35)
            .multilineTextAlignment(.leading)
    }
    
    func setupTexSubtitletMod() -> some View {
        self
            .font(.system(size: 15, weight: .regular, design: .default))
            .lineSpacing(21 - 15)
            .kerning(-0.20)
            .multilineTextAlignment(.leading)
            .foregroundColor(Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.8))
    }
    
}
