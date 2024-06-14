//
//  CountryRow.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import SwiftUI

struct CountryRow: View {
    
    var country: Country
    
    var body: some View {
        HStack {
            Text(country.flagEmoji)
                .frame(height: 24.0)
            
            Text(country.countryName)
                .font(.custom("SF Pro Text", size: 17))
                .fontWeight(.regular)
                .lineSpacing(24 - 17)
                .kerning(-0.408)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding(.vertical, 8)
        .background(Color.clear)
        .listRowInsets(EdgeInsets())
    }
    
}
