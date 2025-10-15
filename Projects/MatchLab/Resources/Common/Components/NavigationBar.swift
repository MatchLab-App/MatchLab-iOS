//
//  NavigationBar.swift
//  MatchLab
//
//  Created by 나현흠 on 10/16/25.
//

import SwiftUI

struct NavigationBar: View {
    var body: some View {
        HStack {
            Button(action: {}, label: {
                Image("DropdownButton")
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical, 13)
                    .padding(.horizontal, 12)
            })
            
            Spacer()
            
            Image("MatchLabLogo")
                .resizable()
                .scaledToFit()
                .padding(.vertical, 14)
            
            Spacer()
            
            Button(action: {}, label: {
                Image("Plane")
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical, 13)
                    .padding(.horizontal, 12)
                    .opacity(0)
            })
        }
        .padding(.horizontal, 30)
        .frame(height: 47)
    }
}

#Preview {
    NavigationBar()
}
