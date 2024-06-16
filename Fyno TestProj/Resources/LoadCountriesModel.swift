//
//  LoadCountriesModel.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 14.06.2024.
//

import SwiftData
import SwiftUI

struct LoadCountriesModel {
    
    static let shared = LoadCountriesModel()
    
    private let loadCountrieQueue = DispatchQueue(label: "loadCountrieQueue.com", qos: .utility, attributes: .initiallyInactive, autoreleaseFrequency: .workItem)
    
    private init() {}
    
    func loadAndSaveCountries(context: ModelContext) {
        guard !UserDefaultStorage.allCountriesWasSaved else { return }
        
        var loadCountries: [Country] = []
        
        loadCountrieQueue.activate()
        
        loadCountrieQueue.sync {
            do {
                guard let url = Bundle.main.url(forResource: "countries", withExtension: "json") else {
                    return
                }
                
                let data = try Data(contentsOf: url)
                let countries = try JSONDecoder().decode([Country].self, from: data)
                
                loadCountries = countries
            } catch {
                print("Failed to decode: \(error.localizedDescription)")
                return
            }
        }
        
        loadCountrieQueue.sync {
            do {
                let savedCountries = try {
                    let fetchDescriptor = FetchDescriptor<Country>(predicate: nil, sortBy: [])
                    return try context.fetch(fetchDescriptor)
                }()
                
                for country in loadCountries {
                    if !savedCountries.contains(country) {
                        context.insert(country)
                    }
                }
            } catch {
                print("Failed to save: \(error.localizedDescription)")
                return
            }
            
            UserDefaultStorage.allCountriesWasSaved = true
            loadCountrieQueue.suspend()
        }
    }
    
}
