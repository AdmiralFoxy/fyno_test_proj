//
//  UserTravelProfileView.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import SwiftUI



final class UserTravelProfileViewModel: ObservableObject {
    
    
    
}

struct UserTravelProfileView: View {
    
    @ObservedObject private var viewModel = UserTravelProfileViewModel()
    @State private var isExpanded: Bool = false
    
//    private let countries_test: [Country] = Country.testCountries
    private let mapSize: (CGFloat) = 390.0 * DefaultViewSize.hScale12iPhone
    
    var body: some View {
        ZStack { }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(alignment: .top) {
                GlobeMapView()
                    .frame(width: mapSize, height: mapSize)
            }
            .overlay(alignment: .bottom) {
                profileView
            }
            .ignoresSafeArea(.all, edges: .all)
    }
    
    var profileView: some View {
        VStack {
            profileCell(profile: .testUser)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    countryInfoView
                    
                    beenCountriesView
                    wantToBeeCountriesView
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 24.0)
        .background {
            RoundedRectangle(cornerRadius: 20.0, style: .circular)
                .foregroundColor(.white)
        }
        .frame(height: 390.0 * DefaultViewSize.hScale12iPhone)
    }
    
    var countryInfoView: some View {
        HStack {
            Spacer()
            
            VStack {
                Text("Your Title")
                    .font(.system(size: 22, weight: .semibold, design: .default))
                    .lineSpacing(28 - 22) // Line height minus font size
                    .kerning(0.35)
                    .multilineTextAlignment(.leading)
                
                Text("Your Subtitle")
                    .font(.system(size: 15, weight: .regular, design: .default))
                    .lineSpacing(21 - 15) // Line height minus font size
                    .kerning(-0.20)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.8))
            }
            
            Spacer()
            
            Divider()
                .frame(width: 1.0, height: 33.0)
            
            Spacer()
            
            VStack {
                Text("Your Title")
                    .font(.system(size: 22, weight: .semibold, design: .default))
                    .lineSpacing(28 - 22)
                    .kerning(0.35)
                    .multilineTextAlignment(.leading)
                
                Text("Your Subtitle")
                    .font(.system(size: 15, weight: .regular, design: .default))
                    .lineSpacing(21 - 15)
                    .kerning(-0.20)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.8))
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 94.0)
        .overlay(alignment: .bottom) {
            Divider()
                .frame(width: 342.0)
        }
    }
    
    var beenCountriesView: some View {
        countriesTableView()
    }
    
    var wantToBeeCountriesView: some View {
        EmptyView()
    }
    
    func countriesTableView() -> some View {
        VStack {
            HStack {
                Text("I’ve been to")
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
            
            ForEach(countries_test) { country in
                CountryRow(country: country)
                    .frame(height: 48.0)
                    .listRowSeparator(.hidden)
            }
            .background(Color.clear)
        }
        .frame(height: 256.0)
    }
    
    func profileCell(profile: UserProfile) -> some View {
        HStack(alignment: .center, spacing: 0.0) {
            Image(uiImage: profile.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80.0, height: 80.0)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 4)
                )
                .padding(.bottom, 24.0)
            
            VStack(alignment: .leading, spacing: 0.0) {
                HStack(alignment: .center, spacing: 0.0) {
                    Text(profile.name)
                        .font(.system(size: 17, weight: .semibold))
                        .kerning(-0.408)
                        .multilineTextAlignment(.leading)
                        .frame(height: 24.0)
                 
                    Image("pencil_icon")
                        .resizable()
                        .frame(width: 24.0, height: 24.0, alignment: .center)
                        .padding(.leading, 4.0)
                }
                
                Text(profile.bioInfo)
                    .fontWithLineHeight(fontSize: 13, fontWeight: .regular, lineHeight: 16)
                    .kerning(-0.078)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.8))
            }
            .padding(.leading, 24.0)
            
            Spacer()
        }
        .frame(height: 80)
    }
    
}

#Preview {
    UserTravelProfileView()
}
