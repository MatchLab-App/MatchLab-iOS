//
//  OpponentType.swift
//  MatchLab
//
//  Created by 나현흠 on 10/18/25.
//

import SwiftUI

struct OpponentType: View {
    var body: some View {
        VStack(spacing: 0) {
            Text(opponentType)
                .font(.appleSDGothicNeo(.bold, size: 24))
                .foregroundStyle(Color.white)
                .padding(.bottom, 8)
            Text(opponentTypeDescription)
                .font(.appleSDGothicNeo(.light, size: 15))
                .foregroundStyle(Color.white)
        }
    }
}
