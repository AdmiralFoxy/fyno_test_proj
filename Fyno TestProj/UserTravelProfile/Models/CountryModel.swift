//
//  CountryModel.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import Foundation
import SwiftData

@Model
final class CountryName: Codable {
    @Attribute
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

@Model
final class Country: Identifiable, Codable {
    @Attribute
    let id: UUID
    
    @Attribute
    var countryName: CountryName
    
    @Attribute
    var capitalCoordinates: Coordinates
    
    @Attribute
    var flagEmoji: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case countryName = "country"
        case capitalCoordinates = "capital_coordinates"
        case flagEmoji = "flag_emoji"
    }
    
    init(id: UUID = UUID(), countryName: CountryName, capitalCoordinates: Coordinates, flagEmoji: String) {
        self.id = id
        self.countryName = countryName
        self.capitalCoordinates = capitalCoordinates
        self.flagEmoji = flagEmoji
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.countryName = try container.decode(CountryName.self, forKey: .countryName)
        self.capitalCoordinates = try container.decode(Coordinates.self, forKey: .capitalCoordinates)
        self.flagEmoji = try container.decode(String.self, forKey: .flagEmoji)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(countryName, forKey: .countryName)
        try container.encode(capitalCoordinates, forKey: .capitalCoordinates)
        try container.encode(flagEmoji, forKey: .flagEmoji)
    }
    
    static let testCountries = [
        Country(countryName: CountryName(name: "United States"), capitalCoordinates: Coordinates(lat: 38.8951, lon: -77.0364), flagEmoji: "🇺🇸"),
        Country(countryName: CountryName(name: "Canada"), capitalCoordinates: Coordinates(lat: 45.4215, lon: -75.6972), flagEmoji: "🇨🇦"),
        Country(countryName: CountryName(name: "United Kingdom"), capitalCoordinates: Coordinates(lat: 51.5074, lon: -0.1278), flagEmoji: "🇬🇧"),
        Country(countryName: CountryName(name: "Germany"), capitalCoordinates: Coordinates(lat: 52.5200, lon: 13.4050), flagEmoji: "🇩🇪"),
        Country(countryName: CountryName(name: "Japan"), capitalCoordinates: Coordinates(lat: 35.6895, lon: 139.6917), flagEmoji: "🇯🇵")
    ]
}

@Model
final class Coordinates: Codable {
    @Attribute
    var lat: Double
    
    @Attribute
    var lon: Double
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
    }
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lat = try container.decode(Double.self, forKey: .lat)
        self.lon = try container.decode(Double.self, forKey: .lon)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lat, forKey: .lat)
        try container.encode(lon, forKey: .lon)
    }
}
