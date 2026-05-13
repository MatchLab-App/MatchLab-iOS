//
//  NoticeView.swift
//  MatchLab
//
//  Created by Codex on 5/12/26.
//

import SwiftUI

struct NoticeView: View {
    let onBack: () -> Void
    let onConfirm: () -> Void

    var body: some View {
        ZStack {
            MatchLabBackground()

            VStack(spacing: 0) {
                MatchLabTopBar(
                    title: nil,
                    showsLogo: false,
                    leftIconName: "Back",
                    leftAccessibilityLabel: String(localized: "accessibility.back"),
                    onLeftTap: onBack
                )

                VStack(alignment: .leading, spacing: 0) {
                    Text(L10n.appServiceTitle)
                        .font(.appleSDGothicNeo(.bold, size: 24))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                        .minimumScaleFactor(0.85)
                        .accessibilityAddTraits(.isHeader)

                    Text("\(L10n.appServiceDescription)\n\n\(L10n.appServiceDescription2)\n\n\(L10n.appServiceDescription3)")
                        .font(.appleSDGothicNeo(.semiBold, size: 15))
                        .foregroundStyle(.white.opacity(0.75))
                        .lineSpacing(4)
                        .padding(.top, 8)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 29)
                .padding(.top, 39)

                Spacer()

                MatchLabPillButton(
                    title: L10n.confirmed,
                    iconSystemName: nil,
                    isPrimary: true,
                    action: onConfirm
                )
                .padding(.horizontal, 46)
                .padding(.bottom, 38)

            }
        }
    }
}

#Preview {
    NoticeView(onBack: {}, onConfirm: {})
}
