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
//    @Query var wantBeenCountries: [Country]
    
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
    
//    init{
//        let haveBeenCountriesName = userProfile.haveBeenCountriesName
//        _haveBeenCountries = Query(filter: #Predicate<Country> { country in
//            return haveBeenCountriesName.forEach { value in
//                country.countryName == value
//            }
//        }, sort: [SortDescriptor(\Country.countryName)], animation: .default)
//        
//        let wantBeCountriesName = userProfile.wantBeCountriesName
//        _wantBeenCountries = Query(filter: #Predicate<Country> { country in
//            wantBeCountriesName.allSatisfy { value in
//                country.countryName == value
//            }
//        }, sort: [SortDescriptor(\Country.countryName)], animation: .default)
//    }
    
    var body: some View {
        GeometryReader { geometry in
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
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .onAppear {
                print(allCountries.dropFirst(5).map { ($0.countryName, $0.capitalCoordinates, $0.persistentModelID) })
            }
        }
    }
    
}

struct CustomAnnotationView: View {
    
    let country: Country
    let haveBeenCountry: Bool
    
    var body: some View {
        ZStack {
            Image("union_icon")
            
            Text(country.flagEmoji)
                .font(.system(size: 20.0))
                .padding(.bottom, 14.0)
        }
        .overlay(alignment: .topTrailing) {
            ZStack {
                Circle()
                    .stroke(Color.white, lineWidth: 1)
                    .background(Circle().foregroundColor(Color(red: 21/255, green: 19/255, blue: 128/255)))
                    .frame(width: 14.0, height: 14.0)
                
                Image("checkmark_icon")
                    .foregroundColor(.white)
                    .font(.system(size: 8))
            }
            .padding(.top, 8.0)
            .padding(.trailing, 10.0)
            .opacity(haveBeenCountry ? 1.0 : 0.0)
        }
    }
}

private let mapSize: (CGFloat) = 390.0 * DefaultViewSize.hScale12iPhone

#Preview {
    CustomAnnotationView(country: Country.testCountries.first!, haveBeenCountry: true)
}
