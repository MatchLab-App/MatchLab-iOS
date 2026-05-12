//
//  StartView.swift
//  MatchLab
//
//  Created by Codex on 5/12/26.
//

import SwiftUI

struct StartView: View {
    let onStart: () -> Void

    private let backgroundTypes: [PokemonType] = [
        .grass, .fire, .water, .electric, .fairy, .ghost,
        .poison, .normal, .ice, .rock, .ground,
        .flying, .psychic, .bug, .dragon, .dark, .steel
    ]

    var body: some View {
        Button(action: onStart) {
            ZStack {
                MatchLabBackground()

                TypeIconCloud(types: backgroundTypes)
                    .opacity(0.8)
                    .blur(radius: 0.5)
                    .accessibilityHidden(true)

                LinearGradient(
                    colors: [.black.opacity(0.15), Color(red: 0.0, green: 0.12, blue: 0.11).opacity(0.85)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                .accessibilityHidden(true)

                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Text(L10n.version)
                            .font(.appleSDGothicNeo(.semiBold, size: 15))
                            .foregroundStyle(.white.opacity(0.75))
                            .padding(.top, 62)
                            .padding(.trailing, 23)
                    }

                    Spacer()

                    Image("MatchLabLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 234, height: 36)
                        .accessibilityLabel(String(localized: "accessibility.logo"))

                    Text(L10n.welcome)
                        .font(.appleSDGothicNeo(.bold, size: 24))
                        .foregroundStyle(Color(red: 0.08, green: 0.96, blue: 0.87))
                        .padding(.top, 162)

                    Text(L10n.touchTheScreen)
                        .font(.appleSDGothicNeo(.semiBold, size: 15))
                        .foregroundStyle(.white)
                        .padding(.top, 52)

                    Spacer()

                    Divider()
                        .background(.white.opacity(0.2))
                        .frame(width: 300)
                        .padding(.bottom, 15)

                    Text(L10n.startDisclaimer)
                        .font(.appleSDGothicNeo(.semiBold, size: 13))
                        .foregroundStyle(.white.opacity(0.75))
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                        .frame(width: 308)
                        .padding(.bottom, 32)
                }
            }
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(L10n.welcome), \(L10n.touchTheScreen)")
    }
}

private struct TypeIconCloud: View {
    let types: [PokemonType]

    private let columns = [
        GridItem(.fixed(58), spacing: 12),
        GridItem(.fixed(58), spacing: 12),
        GridItem(.fixed(58), spacing: 12),
        GridItem(.fixed(58), spacing: 12)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(types) { type in
                Image(type.bigImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 58, height: 58)
            }
        }
        .frame(width: 268)
        .rotationEffect(.degrees(-8))
        .offset(y: -26)
    }
}

#Preview {
    StartView {}
}
