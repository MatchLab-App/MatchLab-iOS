//
//  HomeView.swift
//  MatchLab
//
//  Created by 나현흠 on 8/6/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel: HomeViewModel
    private let onSearch: () -> Void
    private let onSettings: () -> Void

    init(
        viewModel: HomeViewModel = HomeViewModel(),
        onSearch: @escaping () -> Void = {},
        onSettings: @escaping () -> Void = {}
    ) {
        self.viewModel = viewModel
        self.onSearch = onSearch
        self.onSettings = onSettings
    }

    private var primaryDefenseBinding: Binding<PokemonType> {
        Binding(
            get: { viewModel.primaryDefenseType },
            set: { _ in }
        )
    }

    private var secondaryDefenseBinding: Binding<PokemonType> {
        Binding(
            get: { viewModel.secondaryDefenseType },
            set: { _ in }
        )
    }

    var body: some View {
        ZStack {
            MatchLabBackground()

            VStack(spacing: 0) {
                MatchLabTopBar(
                    leftIconName: viewModel.step == .selectFirstOpponentType ? "DropdownButton" : "Back",
                    leftAccessibilityLabel: viewModel.step == .selectFirstOpponentType
                    ? String(localized: "accessibility.menu")
                    : String(localized: "accessibility.back"),
                    onLeftTap: {
                        if viewModel.step == .selectFirstOpponentType {
                            viewModel.isMenuPresented = true
                        } else {
                            viewModel.goBack()
                        }
                    },
                    showsTrailingAction: viewModel.step != .selectFirstOpponentType
                )

                if viewModel.step == .selectFirstOpponentType {
                    SearchButton(action: onSearch)
                        .padding(.top, 19)
                        .padding(.bottom, 33)
                } else {
                    Spacer()
                        .frame(height: 40)
                }

                HomeTitleBlock(viewModel: viewModel)

                Spacer()
                    .frame(height: 32)

                HomeTypeSelectionBlock(viewModel: viewModel)

                Text(viewModel.prompt)
                    .font(.appleSDGothicNeo(.semiBold, size: 15))
                    .foregroundStyle(.white.opacity(0.75))
                    .multilineTextAlignment(.center)
                    .lineSpacing(2)
                    .frame(maxWidth: 296)
                    .padding(.top, viewModel.step == .selectFirstOpponentType ? 40 : 26)
                    .accessibilityLabel(viewModel.prompt)

                if viewModel.step != .selectFirstOpponentType {
                    MatchLabPillButton(
                        title: viewModel.actionTitle,
                        iconSystemName: nil,
                        isPrimary: viewModel.step != .selectAttackType,
                        isEnabled: viewModel.actionEnabled,
                        action: { viewModel.performPrimaryAction() }
                    )
                    .padding(.horizontal, 46)
                    .padding(.top, 30)
                }

                CustomDivider()
                    .padding(.top, viewModel.step == .selectFirstOpponentType ? 47 : 33)
                    .padding(.bottom, 33)

                TypeSelectCarousel(
                    selectedType1: primaryDefenseBinding,
                    selectedType2: secondaryDefenseBinding,
                    selectedAttackType: viewModel.selectedAttackType,
                    onSelect: { type in
                        viewModel.select(type)
                    }
                )

                Spacer(minLength: 0)
            }

            if viewModel.isMenuPresented {
                HomeMenuOverlay(
                    onClose: {
                        viewModel.isMenuPresented = false
                    },
                    onSearch: {
                        viewModel.isMenuPresented = false
                        onSearch()
                    },
                    onSettings: {
                        viewModel.isMenuPresented = false
                        onSettings()
                    }
                )
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.18), value: viewModel.step)
        .animation(.easeInOut(duration: 0.18), value: viewModel.isMenuPresented)
    }
}

private struct HomeTitleBlock: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        VStack(spacing: 8) {
            Text(viewModel.title)
                .font(.appleSDGothicNeo(.bold, size: 24))
                .foregroundStyle(titleColor)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .accessibilityAddTraits(.isHeader)

            Text(viewModel.subtitle)
                .font(.appleSDGothicNeo(.semiBold, size: 15))
                .foregroundStyle(subtitleColor)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
    }

    private var titleColor: Color {
        if viewModel.step == .result && viewModel.effectivenessSummary.multiplier == 0 {
            return viewModel.effectivenessSummary.tint
        }
        return .white
    }

    private var subtitleColor: Color {
        switch viewModel.step {
        case .result:
            return viewModel.effectivenessSummary.tint
        default:
            return .white.opacity(0.75)
        }
    }
}

private struct HomeTypeSelectionBlock: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        VStack(spacing: 11) {
            if viewModel.step == .selectFirstOpponentType || viewModel.step == .selectSecondOpponentType {
                Image("SelectedTriangle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17, height: 13)
                    .accessibilityHidden(true)

                TypeSelectionCard(
                    title: L10n.defense,
                    types: [viewModel.primaryDefenseType, viewModel.secondaryDefenseType],
                    width: 158,
                    accessibilityLabel: String(localized: "accessibility.selected.defense")
                )
            } else {
                HStack(spacing: 27) {
                    TypeSelectionCard(
                        title: L10n.defense,
                        types: [viewModel.primaryDefenseType, viewModel.secondaryDefenseType],
                        width: 158,
                        accessibilityLabel: String(localized: "accessibility.selected.defense")
                    )

                    VStack(spacing: 11) {
                        Image("SelectedTriangle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17, height: 13)
                            .accessibilityHidden(true)

                        TypeSelectionCard(
                            title: L10n.attack,
                            types: [viewModel.selectedAttackType],
                            width: 100,
                            accessibilityLabel: String(localized: "accessibility.selected.attack")
                        )
                    }
                }
            }
        }
    }
}

private struct HomeMenuOverlay: View {
    let onClose: () -> Void
    let onSearch: () -> Void
    let onSettings: () -> Void

    var body: some View {
        ZStack {
            MatchLabBackground()

            VStack(spacing: 0) {
                MatchLabTopBar(
                    showsLogo: true,
                    leftIconName: "Back",
                    leftAccessibilityLabel: String(localized: "accessibility.close.menu"),
                    onLeftTap: onClose
                )

                SearchButton(action: onSearch)
                    .padding(.top, 16)

                VStack(spacing: 20) {
                    MenuActionRow(
                        title: L10n.currentRecords,
                        systemImageName: "clock.arrow.circlepath",
                        action: {}
                    )

                    MenuActionRow(
                        title: L10n.viewTypeChard,
                        systemImageName: "tablecells",
                        action: {}
                    )

                    MenuActionRow(
                        title: L10n.setting,
                        systemImageName: "gearshape.fill",
                        action: onSettings
                    )
                }
                .padding(.horizontal, 27)
                .padding(.top, 17)

                Spacer()

                HomeIndicator()
                    .padding(.bottom, 5)
            }
        }
    }
}

private struct MenuActionRow: View {
    let title: String
    let systemImageName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(Color("buttonColor"))
                        .frame(width: 58, height: 58)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.14), lineWidth: 1)
                        )

                    Image(systemName: systemImageName)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.86))
                        .accessibilityHidden(true)
                }

                Text(title)
                    .font(.appleSDGothicNeo(.bold, size: 18))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)

                Spacer()
            }
            .frame(height: 58)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
    }
}

#Preview {
    HomeView()
}
