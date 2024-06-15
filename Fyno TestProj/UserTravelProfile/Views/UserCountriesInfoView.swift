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
    
    private let vResize = DefaultViewSize.vScale12iPhone
    
    private var userBeenCountrCount: Int {
        userProfile.first?.haveBeenCountriesName.count ?? 0
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .center, spacing: 0.0) {
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
            
            VStack(alignment: .center, spacing: 0.0) {
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
        .frame(height: 74.0 * vResize)
    }
    
    func setupPercentageView() -> some View {
        let percentage = (Double(userBeenCountrCount) / Double(allCountries.count)) * 100
        let formattedPercentage = String(format: "%.f%%", percentage)
        
        return Text(formattedPercentage)
    }
    
}
