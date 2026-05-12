//
//  NavigationBar.swift
//  MatchLab
//
//  Created by 나현흠 on 10/16/25.
//

import SwiftUI

struct NavigationBar: View {
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                isSelected.toggle()
            }, label: {
                Image(isSelected ? "Back" : "DropdownButton")
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical, 13)
                    .padding(.horizontal, 12)
            })
            .accessibilityLabel(isSelected ? String(localized: "accessibility.back") : String(localized: "accessibility.menu"))
            
            Spacer()
            
            Image("MatchLabLogo")
                .resizable()
                .scaledToFit()
                .padding(.vertical, 14)
                .accessibilityLabel(String(localized: "accessibility.logo"))
            
            Spacer()
            
            Button(action: {
                //TODO: 채우기
            }, label: {
                Image("Plane")
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical, 13)
                    .padding(.horizontal, 12)
                    .opacity(isSelected ? 1 : 0)
            })
            .accessibilityHidden(!isSelected)
        }
        .padding(.horizontal, 30)
        .frame(height: 47)
    }
}

#Preview {
    NavigationBar(isSelected: .constant(false))
}
