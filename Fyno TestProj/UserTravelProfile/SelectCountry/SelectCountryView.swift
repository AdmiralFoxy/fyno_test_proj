//
//  SelectCountryView.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import SwiftUI
import SwiftData

struct SelectCountryView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var countries: [Country]
    
    @StateObject private var viewModel: SelectCountryViewModel
    
    init(_ viewModel: SelectCountryViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        EmptyView()
    }
    
}
