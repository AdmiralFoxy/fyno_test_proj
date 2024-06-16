//
//  GlobeMapView.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import SwiftUI
import MapKit
import SwiftData

struct GlobeMapView: View {
    
    @Query var allCountries: [Country]
    @Query var userProfile: [UserProfile]
    
    @State private var countriesForShown: [Country] = []
    @State private var region = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 90, longitudeDelta: 190)
    ))
    
    var filteredHaveBeenCountries: [Country] {
        return allCountries.filter {
            return userProfile.first!.haveBeenCountriesName.contains($0.countryName)
        }
    }
    var filteredWantBeCountries: [Country] {
        return allCountries.filter {
            return userProfile.first!.wantBeCountriesName.contains($0.countryName)
        }
    }
    var mapCamera: MapCameraPosition {
        let camera = MapCamera(
            centerCoordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            distance: 32000000,
            heading: 0,
            pitch: 0
        )
        return MapCameraPosition.camera(camera)
    }
    
    var body: some View {
        Map(initialPosition: mapCamera, interactionModes: [.pan]) {
            ForEach(filteredHaveBeenCountries) { country in
                Annotation("", coordinate: CLLocationCoordinate2D(latitude: country.capitalCoordinates?.lat ?? 0.0, longitude: country.capitalCoordinates?.lon ?? 0.0), anchor: .center) {
                    CustomAnnotationView(country: country, haveBeenCountry: true)
                }
            }
            
            ForEach(filteredWantBeCountries) { country in
                Annotation("", coordinate: CLLocationCoordinate2D(latitude: country.capitalCoordinates?.lat ?? 0.0, longitude: country.capitalCoordinates?.lon ?? 0.0), anchor: .center) {
                    CustomAnnotationView(country: country, haveBeenCountry: false)
                }
            }
        }
        .mapStyle(.hybrid(elevation: .realistic))
        .overlay(alignment: .bottom, content: {
            Color.black.frame(height: 24.0)
        })
        .onAppear {
            print(allCountries.dropFirst(5).map { ($0.countryName, $0.capitalCoordinates, $0.persistentModelID) })
        }
    }
    
}

private let mapSize: (CGFloat) = 390.0 * DefaultViewSize.hScale12iPhone

#Preview {
    GlobeMapView()
        .frame(width: mapSize, height: mapSize)
}
