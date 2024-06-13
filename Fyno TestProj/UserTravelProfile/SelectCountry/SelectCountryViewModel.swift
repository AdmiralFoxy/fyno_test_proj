//
//  SelectCountryViewModel.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
final class SelectCountryViewModel: ObservableObject {
    @Published var countries: [Country] = []
    private var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func loadAllData() {
        Task {
            if await !loadDataFromDatabase() {
                loadDataFromJSONInBackground()
            }
        }
    }
    
    private func loadDataFromJSONInBackground() {
        DispatchQueue.global(qos: .background).async {
            guard let url = Bundle.main.url(forResource: "countries", withExtension: "json") else {
                print("Failed to locate countries.json file.")
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                let decodedCountries = try JSONDecoder().decode([Country].self, from: data)
                Task { @MainActor in
                    self.saveToDatabase(decodedCountries)
                }
            } catch {
                print("Failed to load and decode countries.json file: \(error)")
            }
        }
    }
    
    private func loadDataFromDatabase() async -> Bool {
        let fetchDescriptor = FetchDescriptor<Country>(predicate: nil, sortBy: [])
        do {
            let countries = try context.fetch(fetchDescriptor)
            if !countries.isEmpty {
                self.countries = countries
                return true
            }
        } catch {
            print("Failed to fetch countries from database: \(error)")
        }
        return false
    }
    
    private func saveToDatabase(_ countries: [Country]) {
        Task { @MainActor in
            do {
                for country in countries {
                    context.insert(country)
                }
                try context.save()
                self.countries = countries
            } catch {
                print("Failed to save countries to database: \(error)")
            }
        }
    }
}
