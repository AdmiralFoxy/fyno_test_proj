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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Country.self,
            UserProfile.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            print("Failed to create ModelContainer: \(error)")
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            UserTravelProfileView()
                .onAppear {
                    LoadCountriesModel.shared.loadAndSaveCountries(context: sharedModelContainer.mainContext)
                }
                .modelContainer(sharedModelContainer)
        }
    }
    
}
