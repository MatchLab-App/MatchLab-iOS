//
//  NextButton.swift
//  MatchLab
//
//  Created by 나현흠 on 10/18/25.
//

import SwiftUI

struct NextButton: View {
    var body: some View {
        if #available(iOS 26.0, *) {
            Button(action: {}, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 28)
                        .glassEffect()
                        .foregroundStyle(Color.button)
                        .frame(height: 58)
                        .padding(.horizontal, 46)
                    Text(goNext)
                        .font(.appleSDGothicNeo(.bold, size: 20))
                        .foregroundStyle(Color.white)
                }
            })
        } else {
            Button(action: {}, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 28)
                        .foregroundStyle(Color.button)
                        .frame(height: 58)
                        .padding(.horizontal, 46)
                    Text(goNext)
                        .font(.appleSDGothicNeo(.bold, size: 20))
                        .foregroundStyle(Color.white)
                }
            })
        }
    }
}

#Preview {
    NextButton()
}
