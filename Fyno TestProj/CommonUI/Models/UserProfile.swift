//
//  UserProfile.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import SwiftUI
import SwiftData
import UIKit


@Model
class UserProfile: Identifiable, Hashable {
    
    @Attribute(.unique)
    var id: UUID
    
    @Attribute(.externalStorage)
    var image: Data
    
    var name: String
    var bioInfo: String
    var haveBeenCountriesName: [String]
    var wantBeCountriesName: [String]
    
    init(id: UUID = UUID(), image: Data, name: String, bioInfo: String, haveBeenCountriesName: [String], wantBeCountriesName: [String]) {
        self.id = id
        self.image = image
        self.name = name
        self.bioInfo = bioInfo
        self.haveBeenCountriesName = haveBeenCountriesName
        self.wantBeCountriesName = wantBeCountriesName
    }
    
    static let testUser = UserProfile(
        image: UIImage(named: "woman_test")!.pngData()!,
        name: "John Doe",
        bioInfo: "Globe-trotter, fearless adventurer, cultural enthusiast, storyteller",
        haveBeenCountriesName: ["United States", "Canada", "Germany", "Montenegro", "Morocco", "Mozambique", "Myanmar (formerly Burma)", "United Kingdom", "Japan", "Monaco", "Mongolia", "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger"],
        wantBeCountriesName: ["United Kingdom", "Japan", "Monaco", "Mongolia", "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger"]
    )
}
