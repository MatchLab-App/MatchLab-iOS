//
//  TypeButton.swift
//  MatchLab
//
//  Created by 나현흠 on 8/26/25.
//

import SwiftUI

struct TypeButton: View {
    @State var imageName: String
    @State private var isSelected: Bool = false
    
    var body: some View {
        Button (action: {
            print("check")
        }, label: {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 73, height: 73)
        })
    }
}

#Preview {
    TypeButton(imageName: "Ground")
}
