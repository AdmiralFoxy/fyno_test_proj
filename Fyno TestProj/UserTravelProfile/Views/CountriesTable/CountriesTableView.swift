//
//  CountriesTableView.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import SwiftUI
import SwiftData

struct CountriesTableView: View {
    
    // MARK: Properties
    
    @Environment(\.modelContext) var modelContext
    
    @Query private var allCountries: [Country]
    @Query private var userProfile: [UserProfile]
    
    @State private var showAddCountry = Bool()
    @State private var countriesToShow: Int = 4
    @State private var isShowMore: Bool = false
    
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
    
    let viewType: CountriesTableViewType
    
    init(viewType: CountriesTableViewType) {
        self.viewType = viewType
    }
    
    // MARK: body
    
    var body: some View {
        content
            .sheet(isPresented: $showAddCountry, content: {
                SelectCountryView(viewType: viewType.mapToSCViewType)
            })
    }
    
}

// MARK: subviews

private extension CountriesTableView {
    
    var content: some View {
        VStack(alignment: .center, spacing: 0.0) {
            Divider()
            
            headerView
            countriesTableView
            seeHideMoreView
        }
        .frame(height: filteredCountries.count == 0 ? 256.0 : nil)
        .padding(.horizontal, 24.0)
    }
    
    @ViewBuilder
    var countriesTableView: some View {
        if filteredCountries.isEmpty {
            emptyTableView
        } else {
            tableViewList
        }
    }
    
    var seeMoreButton: some View {
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
                    .setupBaseTextMod()
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.8))
                    .padding(.leading, 6.0)
            }
        }
        .opacity(filteredCountries.count - countriesToShow == 0 ? 0.0 : 1.0)
    }
    
    @ViewBuilder
    var seeHideMoreView: some View {
        if filteredCountries.count >= countriesToShow {
            HStack(alignment: .center, spacing: 0.0) {
                seeMoreButton
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        countriesToShow = 4
                        isShowMore = false
                    }
                }) {
                    HStack {
                        Text("Hide All")
                            .setupBaseTextMod()
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
    
    var tableViewList: some View {
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
    
    var headerView: some View {
        HStack {
            Text(viewType == .haveBeen ? "I’ve been to" : "My bucket list")
                .setupBaseTextMod()
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            addCountryButton
        }
        .frame(height: 48.0, alignment: .center)
        .padding(.top, 8.0)
    }
    
    var addCountryButton: some View {
        Button { showAddCountry = true } label: {
            HStack(alignment: .center, spacing: 0.0) {
                Image("plus_icon")
                    .resizable()
                    .frame(width: 32.0, height: 32.0, alignment: .center)
                
                Text("Add country")
                    .font(.system(size: 15, weight: .semibold, design: .default))
                    .lineSpacing((32 - 15))
                    .kerning(-0.1)
                    .multilineTextAlignment(.trailing)
                    .foregroundStyle(Color(red: 88 / 255, green: 86 / 255, blue: 214 / 255))
                    .padding(.trailing, 8.0)
            }
            .padding(.horizontal, 8.0)
            .background {
                RoundedRectangle(cornerRadius: 40.0)
                    .foregroundStyle(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
            }
        }.frame(height: 32.0, alignment: .center)
    }
    
    var emptyTableView: some View {
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
    }
    
}

private extension View {
    
    func setupBaseTextMod() -> some View {
        self
            .font(.system(size: 17, weight: .semibold, design: .default))
            .lineSpacing(24 - 17)
            .kerning(-0.408)
    }
    
}

//MARK: Helper Methods

private extension CountriesTableView {
    
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

//MARK: Preview

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
