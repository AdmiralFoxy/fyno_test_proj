//
//  CountriesTableView.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import SwiftUI
import SwiftData

extension Color {
    static let customColor = Color(UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.8))
}

enum CountriesTableViewType {
    
    case haveBeen
    case wantBe
    
    var mapToSCViewType: SelectCountryViewType {
        switch self {
        case .haveBeen:
            return .saveHaveBeen
            
        case .wantBe:
            return .saveWantBe
        }
    }
    
}

struct CountriesTableView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var showAddCountry = Bool()
    @State private var countriesToShow: Int = 4
    @State private var isShowMore: Bool = false
    
    @Query private var allCountries: [Country]
    @Query private var userProfile: [UserProfile]
    
    let viewType: CountriesTableViewType
    
    var user: UserProfile {
        userProfile.first ?? .testUser
    }
    
    var filteredCountries: [Country] {
        return allCountries.filter {
            return viewType == .haveBeen
            ? user.haveBeenCountriesName.contains($0.countryName)
            : user.wantBeCountriesName.contains($0.countryName)
        }
    }
    
    init(viewType: CountriesTableViewType) {
        self.viewType = viewType
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0.0) {
            Divider()
            
            HStack {
                Text(viewType == .haveBeen ? "I’ve been to" : "My bucket list")
                    .font(.system(size: 17, weight: .semibold, design: .default))
                    .lineSpacing((24 - 17))
                    .kerning(-0.408)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack(alignment: .center, spacing: 0.0) {
                        Image("plus_icon")
                            .resizable()
                            .frame(width: 32.0, height: 32.0, alignment: .center)
                        
                        Button(action: { showAddCountry = true }, label: {
                            Text("Add country")
                                .font(.system(size: 15, weight: .semibold, design: .default))
                                .lineSpacing((32 - 15))
                                .kerning(-0.1)
                                .multilineTextAlignment(.trailing)
                                .foregroundStyle(Color(red: 88 / 255, green: 86 / 255, blue: 214 / 255))
                                .padding(.trailing, 8.0)
                        })
                    }
                    .padding(.horizontal, 8.0)
                    .background {
                        RoundedRectangle(cornerRadius: 40.0)
                            .foregroundStyle(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
                    }
                }.frame(height: 32.0, alignment: .center)
                
            }
            .frame(height: 48.0, alignment: .center)
            .padding(.top, 8.0)
            
            if filteredCountries.isEmpty {
                VStack(alignment: .center, spacing: 20) {
                    Spacer()
                    
                    Image(systemName: "globe")
                        .resizable()
                        .frame(width: 56.0, height: 56.0)
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.green]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("You don't have any country")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    Text("Please add some countries to your list.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
            } else {
                List {
                    ForEach(filteredCountries.prefix(isShowMore ? countriesToShow : filteredCountries.count > 4 ? 3 : 4), id: \.self) { country in
                        CountryRow(country: country)
                            .frame(height: 48.0 )
                            .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: deleteItems)
                    .background(Color.clear)
                }
                .listStyle(PlainListStyle())
                .scrollDisabled(true)
                .scrollIndicators(.hidden)
                .frame(height: calculateFrameHeight())
            }
            
            if filteredCountries.count >= countriesToShow {
                HStack(alignment: .center, spacing: 0.0) {
                    Button(action: {
                        withAnimation {
                            countriesToShow = min(countriesToShow + 5, filteredCountries.count)
                            isShowMore = true
                        }
                    }) {
                        HStack(alignment: .center, spacing: 0.0) {
                            Image("chevron-down-small")
                                .resizable()
                                .frame(width: 24.0, height: 24.0)
                            
                            Text("See \(filteredCountries.count > 4 ? (!isShowMore ? filteredCountries.count - countriesToShow + 1 : filteredCountries.count - countriesToShow).description : "" ) More")
                                .font(.system(size: 17, weight: .regular, design: .default))
                                .lineSpacing(24 - 17)
                                .kerning(-0.40799999237060547)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.8))
                                .padding(.leading, 6.0)
                        }
                    }
                    .opacity(filteredCountries.count - countriesToShow == 0 ? 0.0 : 1.0)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            countriesToShow = 4
                            isShowMore = false
                        }
                    }) {
                        HStack {
                            Text("Hide All")
                                .font(.system(size: 17, weight: .regular, design: .default))
                                .lineSpacing(24 - 17)
                                .kerning(-0.40799999237060547)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.8))
                        }
                    }
                    .opacity(countriesToShow > 4 ? 1.0 : 0.0)
                    .padding(.trailing, 16.0)
                }
                .frame(height: filteredCountries.count <= 4 ? 0.0 : 48.0)
            }
        }
        .frame(height: filteredCountries.count == 0 ? 256.0 : nil)
        .padding(.horizontal, 24.0)
        .sheet(isPresented: $showAddCountry, content: {
            SelectCountryView(viewType: viewType.mapToSCViewType)
        })
    }
    
    private func calculateFrameHeight() -> CGFloat {
            if filteredCountries.count > 4 {
                return CGFloat(isShowMore ? countriesToShow : countriesToShow - 1) * 48.0
            } else if filteredCountries.count == 4 {
                return CGFloat(4) * 48.0 + 24.0
            } else {
                return CGFloat(filteredCountries.count) * 48.0 + 24.0
            }
        }
    
    private func deleteItems(at offsets: IndexSet) {
        withAnimation {
            switch viewType {
            case .haveBeen:
                var countriesArray = Array(user.haveBeenCountriesName)
                offsets.forEach { index in
                    countriesArray.remove(at: index)
                }
                
                user.haveBeenCountriesName = Set(countriesArray)
                
            case .wantBe:
                var countriesArray = Array(user.wantBeCountriesName)
                offsets.forEach { index in
                    countriesArray.remove(at: index)
                }
                
                user.wantBeCountriesName = Set(countriesArray)
            }
            
            modelContext.insert(user)
        }
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
            CountriesTableView(viewType: .haveBeen)
        }
        .onAppear {
        }
        .modelContainer(container)
    } catch {
        return Text("")
    }
}
