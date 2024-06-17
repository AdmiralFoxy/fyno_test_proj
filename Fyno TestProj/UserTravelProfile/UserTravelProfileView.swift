//
//  UserTravelProfileView.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import Combine
import SwiftUI
import SwiftData

final class UserTravelProfileViewModel: ObservableObject {
    
    @Published var userCountriesTableViewState: ViewState = .idle
    @Published private(set) var isShowLoaderForTVstate: ViewState = .idle
    
    private var anyCancellable = Set<AnyCancellable>()
    
    init() {
        
        $userCountriesTableViewState.sink { [weak self] state in
            self?.isShowLoaderForTVstate = state
        }.store(in: &anyCancellable)
        
    }
    
}

struct UserTravelProfileView: View {
    
    // MARK: Properties
    
    @Environment(\.modelContext) var modelContext
    @ObservedObject private var viewModel = UserTravelProfileViewModel()
    
    private let mapSize: (CGFloat) = 390.0 * DefaultViewSize.hScale12iPhone
    
    // MARK: body
    
    var body: some View {
        content
            .onAppear {
                if UserDefaultStorage.startUserWasSetup == false {
                    modelContext.insert(UserProfile.testUser)
                    UserDefaultStorage.startUserWasSetup = true
                }
            }
    }
}

// MARK: Subviews

private extension UserTravelProfileView {
    
    var content: some View {
        ZStack { }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(alignment: .top) {
                GlobeMapView()
                    .modelContext(modelContext)
                    .frame(width: mapSize, height: mapSize + 44.0)
                    .padding(.top, -24.0)
            }
            .overlay(alignment: .bottom) {
                profileView
            }
            .overlay(alignment: .topLeading, content: {
                Image("left_button_icon")
                    .padding(.leading, 8.0)
                    .padding(.top, 32.0)
                
            })
            .ignoresSafeArea(.all, edges: .all)
            .overlay(alignment: .center) {
                if viewModel.isShowLoaderForTVstate == .loading {
                    ProgressLoadView()
                        .animation(.default, value: 0.35)
                }
            }
    }
    
    var profileView: some View {
        VStack {
            ProfileInfoCellView()
                .modelContext(modelContext)
            
            infoScrollView
        }
        .background {
            RoundedRectangle(cornerRadius: 20.0, style: .circular)
                .foregroundColor(.white)
        }
        .padding(.top, mapSize - 40.0)
    }
    
    var infoScrollView: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 0.0) {
                UserCountriesInfoView()
                    .modelContext(modelContext)
                    .padding(.top, 8.0)
                
                beenCountriesView
                wantToBeeCountriesView
            }
            .padding(.bottom, 30.0)
        }.disableBounces()
    }
    
    var beenCountriesView: some View {
        CountriesTableView(viewState: $viewModel.userCountriesTableViewState, viewType: .haveBeen)
            .modelContext(modelContext)
    }
    
    var wantToBeeCountriesView: some View {
        CountriesTableView(viewState: $viewModel.userCountriesTableViewState, viewType: .wantBe)
            .modelContext(modelContext)
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
        
        return UserTravelProfileView()
            .modelContainer(container)
    } catch {
        return Text("")
    }
    
}
