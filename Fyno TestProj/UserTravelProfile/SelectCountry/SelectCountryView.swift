//
//  SelectCountryView.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import SwiftUI
import SwiftData

enum ViewState: Equatable {
    
    case idle
    case loading
    case onSuccess
    case onError(message: String)
    
}

enum SelectCountryViewType {
    
    case saveWantBe
    case saveHaveBeen
    
}

struct SelectCountryView: View {
    
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
    
    var body: some View {
        VStack(alignment: .center, spacing: 0.0) {
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
                                user.wantBeCountriesName.insert(country.countryName)
                            case .saveHaveBeen:
                                user.haveBeenCountriesName.insert(country.countryName)
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
        .padding(.horizontal, 24.0)
        .frame(maxWidth: .infinity)
        .overlay(alignment: .center) {
            if viewState == .loading {
                ProgressLoadView()
            }
        }
    }
}

struct ProgressLoadView: View {
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
            
            ProgressView()
        }
        .ignoresSafeArea(.all)
    }
    
}

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
