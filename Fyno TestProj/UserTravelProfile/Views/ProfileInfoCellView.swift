//
//  ProfileInfoCellView.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 13.06.2024.
//

import SwiftUI
import SwiftData

struct ProfileInfoCellView: View {
    
    // MARK: Properties
    
    @Environment(\.modelContext) var modelContext
    @Query private var userProfile: [UserProfile]
    
    // MARK: body
    
    var body: some View {
        content
        .padding(.horizontal, 24.0)
    }
    
}

// MARK: - subviews

private extension ProfileInfoCellView {
    
    var content: some View {
        HStack(alignment: .center, spacing: 0.0) {
            profileIcon
            
            profileInfo
            
            Spacer()
        }
        .frame(height: 80)
    }
    
    var profileIcon: some View {
        Image(uiImage: setupProfileImage(userProfile))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 80.0, height: 80.0)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 4)
            )
            .padding(.bottom, 24.0)
    }
    
    var profileInfo: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            profileTitle
            
            profileSubtitle
        }
        .padding(.leading, 24.0)
    }
    
    var profileTitle: some View {
        HStack(alignment: .center, spacing: 0.0) {
            Text(userProfile.first?.name ?? "UNFIND")
                .font(.system(size: 17, weight: .semibold))
                .kerning(-0.408)
                .multilineTextAlignment(.leading)
                .frame(height: 24.0)
            
            Image("pencil_icon")
                .resizable()
                .frame(width: 24.0, height: 24.0, alignment: .center)
                .padding(.leading, 4.0)
        }
    }
    
    var profileSubtitle: some View {
        Text(userProfile.first?.bioInfo ?? "NOT FIND")
            .font(.system(size: 13.0, weight: .regular))
            .lineSpacing(16 - 13)
            .kerning(-0.078)
            .multilineTextAlignment(.leading)
            .foregroundColor(Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.8))
    }
    
}

// MARK: helper methods

private extension ProfileInfoCellView {
    
    func setupProfileImage(_ userProfile: [UserProfile]) -> UIImage {
        guard let profile = userProfile.first, let image = UIImage(data: profile.image) else { return UIImage() }
        
        return image
    }
    
}
