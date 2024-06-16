//
//  ProgressLoadView.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 16.06.2024.
//

import SwiftUI

struct ProgressLoadView: View {
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
            
            ProgressView()
        }
        .ignoresSafeArea(.all)
    }
    
}
