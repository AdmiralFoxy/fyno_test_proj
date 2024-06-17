//
//  SelectCountryView.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import SwiftUI
import SwiftData

struct SelectCountryView: View {
    
    // MARK: Properties
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Country.countryName, animation: .default) private var allCountries: [Country]
    @Query private var userProfile: [UserProfile]
    
    @State private var viewState: ViewState = .idle
    
    var filteredAllCountries: [Country] {
        return allCountries.filter {
            return !userProfile.first!.haveBeenCountriesName.contains($0.countryName) && !userProfile.first!.wantBeCountriesName.contains($0.countryName)
        }
    }
    
    let viewType: SelectCountryViewType
    
    init( viewType: SelectCountryViewType) {
        self.viewType = viewType
    }
    
    // MARK: body
    
    var body: some View {
        content
        .overlay(alignment: .center) {
            if viewState == .loading {
                ProgressLoadView()
            }
        }
    }
}

// MARK: Subviews

private extension SelectCountryView {
    
    var content: some View {
        VStack(alignment: .center, spacing: 0.0) {
            headerView
            
            countryListView
        }
        .padding(.horizontal, 24.0)
        .frame(maxWidth: .infinity)
    }
    
    var headerView: some View {
        ZStack {}
            .frame(height: 80.0)
            .frame(maxWidth: .infinity)
            .overlay(alignment: .center, content: {
                Text("Select \(viewType == .saveHaveBeen ? "Have Been" : "Want Be" ) Country")
            })
            .overlay(alignment: .trailing) {
                Button(action: dismiss.callAsFunction, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                        .background(Color.gray.opacity(0.5))
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })
            }
            .padding(.horizontal, 20.0)
    }
    
    var countryListView: some View {
        List(filteredAllCountries) { country in
            HStack(alignment: .center, spacing: 0.0) {
                CountryRow(country: country)
                
                Button(action: {
                    withAnimation {
                        viewState = .loading
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        guard let user = userProfile.first else {
                            viewState = .onError(message: "Error user load")
                            return
                        }
                        
                        switch viewType {
                        case .saveWantBe:
                            user.wantBeCountriesName.append(country.countryName)
                        case .saveHaveBeen:
                            user.haveBeenCountriesName.append(country.countryName)
                        }
                        modelContext.insert(user)
                        
                        dismiss.callAsFunction()
                    }
                }, label: {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 20.0, height: 20.0)
                        .foregroundColor(.green)
                })
            }
            .frame(height: 48.0)
            .listSectionSeparator(.hidden, edges: [.top, .bottom])
        }
        .disableBounces()
        .background(Color.clear)
        .listStyle(PlainListStyle())
        .scrollIndicators(.hidden)
    }
    
}

// MARK: Preview

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Schema([
            Country.self,
            UserProfile.self
        ]), configurations: config)
        
        return VStack {
            SelectCountryView(viewType: .saveHaveBeen)
        }
        .onAppear {
            container.mainContext.insert(UserProfile.testUser)
            LoadCountriesModel.shared.loadAndSaveCountries(context: container.mainContext)
        }
        .modelContainer(container)
    } catch {
        return Text("")
    }
}
