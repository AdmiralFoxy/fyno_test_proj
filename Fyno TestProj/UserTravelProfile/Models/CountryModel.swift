//
//  CountryModel.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import Foundation
import SwiftData

@Model
final class Country: Identifiable, Codable {
    
    @Attribute
    var countryName: String
    
    @Attribute
    var capitalCoordinates: Coordinates
    
    @Attribute
    var flagEmoji: String
    
    enum CodingKeys: String, CodingKey {
        case countryName = "country"
        case capitalCoordinates = "capital_coordinates"
        case flagEmoji = "flag_emoji"
    }
    
    init(countryName: String, capitalCoordinates: Coordinates, flagEmoji: String) {
        self.countryName = countryName
        self.capitalCoordinates = capitalCoordinates
        self.flagEmoji = flagEmoji
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.countryName = try container.decode(String.self, forKey: .countryName)
        self.capitalCoordinates = try container.decode(Coordinates.self, forKey: .capitalCoordinates)
        self.flagEmoji = try container.decode(String.self, forKey: .flagEmoji)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(countryName, forKey: .countryName)
        try container.encode(capitalCoordinates, forKey: .capitalCoordinates)
        try container.encode(flagEmoji, forKey: .flagEmoji)
    }
    
    static let testCountries = [
        Country(countryName: "United States", capitalCoordinates: Coordinates(lat: 38.8951, lon: -77.0364), flagEmoji: "🇺🇸"),
        Country(countryName: "Canada", capitalCoordinates: Coordinates(lat: 45.4215, lon: -75.6972), flagEmoji: "🇨🇦"),
        Country(countryName: "United Kingdom", capitalCoordinates: Coordinates(lat: 51.5074, lon: -0.1278), flagEmoji: "🇬🇧"),
        Country(countryName: "Germany", capitalCoordinates: Coordinates(lat: 52.5200, lon: 13.4050), flagEmoji: "🇩🇪"),
        Country(countryName: "Japan", capitalCoordinates: Coordinates(lat: 35.6895, lon: 139.6917), flagEmoji: "🇯🇵"),
        Country(countryName: "Monaco", capitalCoordinates: Coordinates(lat: 43.7333, lon: 7.4167), flagEmoji: "🇲🇨"),
        Country(countryName: "Mongolia", capitalCoordinates: Coordinates(lat: 47.8864, lon: 106.9057), flagEmoji: "🇲🇳"),
        Country(countryName: "Montenegro", capitalCoordinates: Coordinates(lat: 42.4416, lon: 19.2662), flagEmoji: "🇲🇪"),
        Country(countryName: "Morocco", capitalCoordinates: Coordinates(lat: 33.9716, lon: -6.8498), flagEmoji: "🇲🇦"),
        Country(countryName: "Mozambique", capitalCoordinates: Coordinates(lat: -25.9664, lon: 32.5737), flagEmoji: "🇲🇿"),
        Country(countryName: "Myanmar (formerly Burma)", capitalCoordinates: Coordinates(lat: 19.7633, lon: 96.0785), flagEmoji: "🇲🇲"),
        Country(countryName: "Namibia", capitalCoordinates: Coordinates(lat: -22.5609, lon: 17.0658), flagEmoji: "🇳🇦"),
        Country(countryName: "Nauru", capitalCoordinates: Coordinates(lat: -0.5228, lon: 166.9315), flagEmoji: "🇳🇷"),
        Country(countryName: "Nepal", capitalCoordinates: Coordinates(lat: 27.7172, lon: 85.3240), flagEmoji: "🇳🇵"),
        Country(countryName: "Netherlands", capitalCoordinates: Coordinates(lat: 52.3676, lon: 4.9041), flagEmoji: "🇳🇱"),
        Country(countryName: "New Zealand", capitalCoordinates: Coordinates(lat: -41.2865, lon: 174.7762), flagEmoji: "🇳🇿"),
        Country(countryName: "Nicaragua", capitalCoordinates: Coordinates(lat: 12.1150, lon: -86.2362), flagEmoji: "🇳🇮"),
        Country(countryName: "Niger", capitalCoordinates: Coordinates(lat: 13.5116, lon: 2.1254), flagEmoji: "🇳🇪")
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
