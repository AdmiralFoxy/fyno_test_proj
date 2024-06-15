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
    
}

struct CountriesTableView: View {
    
    @State private var countriesToShow: Int = 4
    @State private var isShowMore: Bool = false
    
    /*@Query*/ private var allCountries: [Country] = Country.testCountries
    /*@Query*/ private var userProfile: [UserProfile] = [.testUser]
    
    let viewType: CountriesTableViewType
    
    var filteredCountries: [Country] {
        return allCountries.filter {
            return viewType == .haveBeen
            ? userProfile.first!.haveBeenCountriesName.contains($0.countryName)
            : userProfile.first!.wantBeCountriesName.contains($0.countryName)
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
                    .lineSpacing(24 - 17)
                    .kerning(-0.408)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack(alignment: .center, spacing: 0.0) {
                        Image("plus_icon")
                            .resizable()
                            .frame(width: 32.0, height: 32.0, alignment: .center)
                        
                        Text("Add country")
                            .font(.system(size: 15, weight: .semibold, design: .default))
                            .lineSpacing(32 - 15) // Line height minus font size
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
            .padding(.top, 16.0)
            
            List {
                ForEach(filteredCountries.prefix(isShowMore ? countriesToShow : (filteredCountries.count > 4 ? 3 : 4))) { country in
                    CountryRow(country: country)
                        .frame(height: 48.0)
                        .listRowSeparator(.hidden)
                }
                .background(Color.clear)
            }
            .listStyle(PlainListStyle())
            .scrollDisabled(true)
            .scrollIndicators(.hidden)
            
            if filteredCountries.count >= countriesToShow {
                HStack(alignment: .center, spacing: 0.0) {
                    Button(action: {
                        withAnimation {
                            countriesToShow = min(countriesToShow + 5, filteredCountries.count)
                            isShowMore = true
                        }
                    }) {
                        HStack {
                            Image("chevron-down-small")
                            
                            Text("See \(filteredCountries.count > 4 ? (!isShowMore ? filteredCountries.count - countriesToShow + 1 : filteredCountries.count - countriesToShow).description : "" ) More")
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            countriesToShow = 4
                            isShowMore = false
                        }
                    }) {
                        HStack {
                            
                            Text("Hide More")
                        }
                    }
                    .opacity(countriesToShow > 4 ? 1.0 : 0.0)
                }
                
            }
            
            Spacer()
        }
        .frame(height: isShowMore ? CGFloat(countriesToShow + 1) * 48.0 : 256.0)
        .padding(.horizontal, 24.0)
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
            Group {
                CountriesTableView(viewType: .haveBeen)
                
                //                CountriesTableView(viewType: .wantBe)
            }.border(.red, width: 1.0)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        .onAppear {
            container.mainContext.insert(UserProfile.testUser)
            LoadCountriesModel.shared.loadAndSaveCountries(context: container.mainContext)
        }
        .modelContainer(container)
    } catch {
        return Text("")
    }
}
