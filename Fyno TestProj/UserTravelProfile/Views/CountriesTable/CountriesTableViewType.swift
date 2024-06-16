//
//  CountriesTableViewType.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 16.06.2024.
//

import SwiftUI

enum CountriesTableViewType {
    
    case haveBeen
    case wantBe
    
    var mapToSCViewType: SelectCountryViewType {
        switch self {
        case .haveBeen:
            return .saveHaveBeen
            
        case .wantBe:
            return .saveWantBe
        }
    }
    
}

extension Color {
    
    static let customColor = Color(UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.8))
    
}
