//
//  UserTravelProfileView.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import Combine
import SwiftUI
import SwiftData

struct UserTravelProfileView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var isExpanded: Bool = false
    
    private let mapSize: (CGFloat) = 390.0 * DefaultViewSize.hScale12iPhone
    
    var body: some View {
        ZStack { }
            .onAppear {
                modelContext.insert(UserProfile.testUser)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(alignment: .top) {
                GlobeMapView()
                    .frame(width: mapSize, height: mapSize + 44.0)
                    .padding(.top, -24.0)
            }
            .overlay(alignment: .bottom) {
                profileView
            }
            .ignoresSafeArea(.all, edges: .all)
    }
    
    var profileView: some View {
        VStack {
            ProfileInfoCellView()
                .modelContext(modelContext)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    UserCountriesInfoView()
                        .modelContext(modelContext)
                    
                    beenCountriesView
                    wantToBeeCountriesView
                }
            }.disableBounces()
            
            Spacer()
        }
        .background {
            RoundedRectangle(cornerRadius: 20.0, style: .circular)
                .foregroundColor(.white)
        }
        .padding(.top, mapSize - 40.0)
    }
    
    var beenCountriesView: some View {
        CountriesTableView(viewType: .haveBeen)
            .modelContext(modelContext)
    }
    
    var wantToBeeCountriesView: some View {
        CountriesTableView(viewType: .wantBe)
            .modelContext(modelContext)
    }
    
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Schema([
            Country.self,
            UserProfile.self
        ]), configurations: config)
        
        return UserTravelProfileView()
            .modelContainer(container)
    } catch {
        return Text("")
    }
}


extension View {
  func disableBounces() -> some View {
    modifier(DisableBouncesModifier())
  }
}

struct DisableBouncesModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .onAppear {
        UIScrollView.appearance().bounces = false
      }
      .onDisappear {
        UIScrollView.appearance().bounces = true
      }
  }
}
