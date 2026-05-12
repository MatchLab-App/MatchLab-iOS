//
//  SettingsView.swift
//  MatchLab
//
//  Created by Codex on 5/12/26.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    let onBack: () -> Void

    var body: some View {
        ZStack {
            MatchLabBackground()

            VStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .fill(Color(red: 0.01, green: 0.09, blue: 0.08).opacity(0.35))
                        .overlay(Rectangle().stroke(Color.white.opacity(0.16), lineWidth: 1))
                        .frame(height: 126)

                    MatchLabTopBar(
                        title: L10n.setting,
                        showsLogo: false,
                        leftIconName: "Back",
                        leftAccessibilityLabel: String(localized: "accessibility.back"),
                        onLeftTap: onBack
                    )
                    .padding(.bottom, 9)
                }
                .ignoresSafeArea(edges: .top)

                VStack(alignment: .leading, spacing: 18) {
                    Text(L10n.languageSetting)
                        .font(.appleSDGothicNeo(.semiBold, size: 15))
                        .foregroundStyle(.white.opacity(0.75))
                        .padding(.leading, 20)

                    SettingsRow {
                        HStack {
                            Text(viewModel.selectedLanguage)
                                .font(.appleSDGothicNeo(.bold, size: 18))
                                .foregroundStyle(.white)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white.opacity(0.75))
                                .accessibilityHidden(true)
                        }
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(L10n.languageSetting)
                    .accessibilityValue(viewModel.selectedLanguage)

                    SettingsRow {
                        Toggle(isOn: $viewModel.isFileAccessEnabled) {
                            Text(L10n.fileAccessPermission)
                                .font(.appleSDGothicNeo(.bold, size: 18))
                                .foregroundStyle(.white)
                        }
                        .toggleStyle(.switch)
                        .tint(Color("buttonColor"))
                    }
                    .padding(.top, 1)

                    NoticeCard()
                        .padding(.top, 1)

                    SettingsRow {
                        HStack(spacing: 10) {
                            Text("Ver.")
                                .font(.appleSDGothicNeo(.bold, size: 18))
                                .foregroundStyle(.white)
                            Text(L10n.version)
                                .font(.appleSDGothicNeo(.semiBold, size: 18))
                                .foregroundStyle(.white.opacity(0.75))
                            Spacer()
                        }
                    }
                    .accessibilityElement(children: .combine)
                }
                .padding(.horizontal, 30)
                .padding(.top, 16)

                Spacer()

                VStack(spacing: 9) {
                    Image("MatchLabLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 124, height: 20)
                        .accessibilityLabel(String(localized: "accessibility.logo"))

                    Text(L10n.contact)
                        .font(.appleSDGothicNeo(.semiBold, size: 15))
                        .foregroundStyle(.white.opacity(0.75))

                    Text(L10n.contactMail)
                        .font(.appleSDGothicNeo(.semiBold, size: 15))
                        .foregroundStyle(.white.opacity(0.75))
                }
                .padding(.bottom, 139)
                .accessibilityElement(children: .combine)

                HomeIndicator()
                    .padding(.bottom, 5)
            }
        }
    }
}

private struct SettingsRow<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        content()
            .padding(.horizontal, 20)
            .frame(height: 58)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 28)
                    .fill(Color.white.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(Color.white.opacity(0.14), lineWidth: 1)
            )
    }
}

private struct NoticeCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            Text(L10n.appServiceTitle)
                .font(.appleSDGothicNeo(.bold, size: 24))
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.75)

            Text(L10n.appServiceDescription)
                .font(.appleSDGothicNeo(.semiBold, size: 13))
                .foregroundStyle(.white.opacity(0.75))
                .lineLimit(3)
                .lineSpacing(2)

            Button(action: {}) {
                Text(L10n.readFullNotice)
                    .font(.appleSDGothicNeo(.semiBold, size: 15))
                    .foregroundStyle(Color(red: 0.08, green: 0.96, blue: 0.87))
                    .frame(height: 32)
                    .padding(.horizontal, 12)
                    .background(
                        Capsule()
                            .fill(Color.white.opacity(0.1))
                    )
                    .overlay(
                        Capsule()
                            .stroke(Color.white.opacity(0.14), lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)
            .accessibilityLabel(L10n.readFullNotice)
        }
        .padding(.horizontal, 17)
        .padding(.vertical, 17)
        .frame(height: 195)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.white.opacity(0.1))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(Color.white.opacity(0.14), lineWidth: 1)
        )
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel(), onBack: {})
}
