//
//  Ext+View.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 16.06.2024.
//

import SwiftUI

extension View {
    
    func disableBounces() -> some View {
        modifier(DisableBouncesModifier())
    }
    
}

struct DisableBouncesModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .onAppear { UIScrollView.appearance().bounces = false }
            .onDisappear { UIScrollView.appearance().bounces = true }
    }
    
}
