//
//  Fyno_TestProjApp.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 12.06.2024.
//

import SwiftUI
import SwiftData

@main
struct Fyno_TestProjApp: App {
    let sharedModelContainer: ModelContainer
    
    init() {
        let schema = Schema([
            Country.self,
            UserProfile.self,
            Coordinates.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            self.sharedModelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            print("Failed to create ModelContainer: \(error)")
            fatalError("Could not create ModelContainer: \(error)")
        }
        
        LoadCountriesModel.shared.loadAndSaveCountries(context: sharedModelContainer.mainContext)
    }
    
    var body: some Scene {
        WindowGroup {
            UserTravelProfileView()
                .modelContainer(sharedModelContainer)
        }
    }
    
}
