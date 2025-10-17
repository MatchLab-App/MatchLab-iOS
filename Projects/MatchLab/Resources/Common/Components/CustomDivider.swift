//
//  CustomDivider.swift
//  MatchLab
//
//  Created by 나현흠 on 10/18/25.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Divider()
            .frame(height: 1)
            .background(Color.white)
            .opacity(0.2)
            .padding(.horizontal, 51)
    }
}

#Preview {
    CustomDivider()
}
