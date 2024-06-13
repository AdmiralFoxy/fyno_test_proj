//
//  GlobeMapView.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import SwiftUI
import MapKit

struct GlobeMapView: View {
    
    @State private var region = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 90, longitudeDelta: 190)
    ))
    
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
        GeometryReader { geometry in
            Map(initialPosition: mapCamera, interactionModes: [.pan]) {
                
            }
            .mapStyle(.hybrid(elevation: .realistic))
            .overlay(alignment: .bottom, content: {
                Color.black.frame(height: 24.0)
            })
            .onMapCameraChange { context in
                print(context.region)
            }
            .onAppear {
            }
            .frame(width: geometry.size.width, height: geometry.size.height * 1.32, alignment: .center)
        }
    }
    
}
