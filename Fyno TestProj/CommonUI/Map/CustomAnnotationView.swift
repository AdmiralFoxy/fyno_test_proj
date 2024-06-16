//
//  CustomAnnotationView.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 16.06.2024.
//

import SwiftUI
import SwiftData

struct CustomAnnotationView: View {
    
    let country: Country
    let haveBeenCountry: Bool
    
    var body: some View {
        ZStack {
            Image("union_icon")
            
            Text(country.flagEmoji)
                .font(.system(size: 20.0))
                .padding(.bottom, 14.0)
        }
        .overlay(alignment: .topTrailing) {
            ZStack {
                Circle()
                    .stroke(Color.white, lineWidth: 1)
                    .background(Circle().foregroundColor(Color(red: 21/255, green: 19/255, blue: 128/255)))
                    .frame(width: 14.0, height: 14.0)
                
                Image("checkmark_icon")
                    .foregroundColor(.white)
                    .font(.system(size: 8))
            }
            .padding(.top, 8.0)
            .padding(.trailing, 10.0)
            .opacity(haveBeenCountry ? 1.0 : 0.0)
        }
    }
}
