//
//  Coordinates.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 16.06.2024.
//

import SwiftData

@Model
final class Coordinates: Codable {
    @Attribute
    var lat: Double
    
    @Attribute
    var lon: Double
    
    @Relationship(deleteRule: .cascade, inverse: \Country.capitalCoordinates)
    var country: [Country]
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
    }
    
    init(lat: Double, lon: Double, country: [Country] = []) {
        self.lat = lat
        self.lon = lon
        self.country = country
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lat = try container.decode(Double.self, forKey: .lat)
        self.lon = try container.decode(Double.self, forKey: .lon)
        self.country = []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lat, forKey: .lat)
        try container.encode(lon, forKey: .lon)
    }
}
