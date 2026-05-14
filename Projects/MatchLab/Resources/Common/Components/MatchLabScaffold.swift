//
//  MatchLabScaffold.swift
//  MatchLab
//
//  Created by Codex on 5/12/26.
//

import SwiftUI

struct MatchLabBackground: View {
    var body: some View {
        LinearGradient(
            colors: [Color.black, Color("bottomColor")],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

struct MatchLabTopBar: View {
    let title: String?
    let showsLogo: Bool
    let leftIconName: String
    let leftAccessibilityLabel: String
    let onLeftTap: () -> Void
    let showsTrailingAction: Bool
    let trailingAccessibilityLabel: String?
    let onTrailingTap: () -> Void

    init(
        title: String? = nil,
        showsLogo: Bool = true,
        leftIconName: String = "DropdownButton",
        leftAccessibilityLabel: String = String(localized: "accessibility.menu"),
        onLeftTap: @escaping () -> Void,
        showsTrailingAction: Bool = false,
        trailingAccessibilityLabel: String? = nil,
        onTrailingTap: @escaping () -> Void = {}
    ) {
        self.title = title
        self.showsLogo = showsLogo
        self.leftIconName = leftIconName
        self.leftAccessibilityLabel = leftAccessibilityLabel
        self.onLeftTap = onLeftTap
        self.showsTrailingAction = showsTrailingAction
        self.trailingAccessibilityLabel = trailingAccessibilityLabel
        self.onTrailingTap = onTrailingTap
    }

    var body: some View {
        HStack {
            Button(action: onLeftTap) {
                Image(leftIconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 23, height: 23)
                    .frame(width: 47, height: 47)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(leftAccessibilityLabel)

            Spacer()

            if showsLogo {
                Image("MatchLabLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 124, height: 20)
                    .accessibilityLabel(String(localized: "accessibility.logo"))
            } else if let title {
                Text(title)
                    .font(.appleSDGothicNeo(.bold, size: 20))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .accessibilityAddTraits(.isHeader)
            } else {
                Color.clear
                    .frame(width: 124, height: 20)
                    .accessibilityHidden(true)
            }

            Spacer()

            Button(action: onTrailingTap) {
                Image("Plane")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 23, height: 23)
                    .frame(width: 47, height: 47)
                    .opacity(showsTrailingAction ? 1 : 0)
            }
            .buttonStyle(.plain)
            .disabled(!showsTrailingAction)
            .accessibilityHidden(!showsTrailingAction || trailingAccessibilityLabel == nil)
            .accessibilityLabel(trailingAccessibilityLabel ?? "")
        }
        .padding(.horizontal, 30)
        .frame(height: 47)
    }
}

struct HomeIndicator: View {
    var body: some View {
        Capsule()
            .fill(.white)
            .frame(width: 153, height: 4)
            .accessibilityHidden(true)
    }
}

struct MatchLabPillButton: View {
    let title: String
    let iconSystemName: String?
    var isPrimary = true
    var isEnabled = true
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 20) {
                if let iconSystemName {
                    Image(systemName: iconSystemName)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.white.opacity(isPrimary ? 1 : 0.5))
                        .accessibilityHidden(true)
                }

                Text(title)
                    .font(.appleSDGothicNeo(.bold, size: 20))
                    .foregroundStyle(.white.opacity(isPrimary ? 1 : 0.5))
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .background(
                RoundedRectangle(cornerRadius: 28)
                    .fill(isPrimary ? Color("buttonColor") : Color.white.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(Color.white.opacity(0.14), lineWidth: 1)
            )
            .opacity(isEnabled ? 1 : 0.55)
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .accessibilityLabel(title)
    }
}

struct TypeSmallToken: View {
    let type: PokemonType

    var body: some View {
        VStack(spacing: 6) {
            Image(type.smallImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .accessibilityHidden(true)

            Text(type.label)
                .font(.appleSDGothicNeo(.semiBold, size: 11))
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .frame(width: 48, height: 61)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(type.label)
    }
}

struct TypeSelectionCard: View {
    let title: String
    let types: [PokemonType]
    var width: CGFloat = 158
    var accessibilityLabel: String
    var isHighlighted: Bool = false

    private var paddedTypes: [PokemonType] {
        let usable = Array(types.prefix(width > 120 ? 2 : 1))
        return usable + Array(repeating: .noType, count: max(0, (width > 120 ? 2 : 1) - usable.count))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(title)
                    .font(.appleSDGothicNeo(.semiBold, size: 12))
                    .foregroundStyle(.white.opacity(0.7))
                Spacer()
                Image(systemName: title == L10n.attack ? "bolt.fill" : "shield.fill")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.white.opacity(0.7))
                    .accessibilityHidden(true)
            }
            .padding(.horizontal, 7)
            .padding(.top, 6)

            Spacer()

            HStack(spacing: 8) {
                ForEach(Array(paddedTypes.enumerated()), id: \.offset) { _, type in
                    TypeSmallToken(type: type)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 10)
        }
        .frame(width: width, height: 93)
        .background(
            RoundedRectangle(cornerRadius: 11)
                .fill(Color(red: 0.01, green: 0.05, blue: 0.05).opacity(0.3))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 11)
                .stroke(Color.white.opacity(0.14), lineWidth: 1)
        )
        .shadow(
            color: isHighlighted ? Color.white.opacity(0.55) : .clear,
            radius: isHighlighted ? 8 : 0,
            x: 0,
            y: 0
        )
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityValue(paddedTypes.map(\.label).joined(separator: ", "))
    }
}

struct MatchLabSkeleton: View {
    var cornerRadius: CGFloat = 12

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.gray.opacity(0.28))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
            )
            .accessibilityHidden(true)
    }
}
