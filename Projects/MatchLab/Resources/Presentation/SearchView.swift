//
//  SearchView.swift
//  MatchLab
//
//  Created by Codex on 5/12/26.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    let onBack: () -> Void
    let onSelect: (PokemonSearchResult) -> Void

    var body: some View {
        ZStack {
            MatchLabBackground()

            VStack(spacing: 0) {
                SearchHeader(query: $viewModel.query, onBack: onBack)

                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.results.prefix(12)) { result in
                            SearchResultRow(
                                result: result,
                                onSelect: {
                                    onSelect(result)
                                }
                            )
                                .padding(.horizontal, 40)
                                .padding(.vertical, 8)
                        }
                    }
                    .padding(.top, 12)
                }

                HomeIndicator()
                    .padding(.bottom, 5)
            }
        }
    }
}

private struct SearchHeader: View {
    @Binding var query: String
    let onBack: () -> Void

    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(Color(red: 0.01, green: 0.09, blue: 0.08).opacity(0.35))
                .overlay(
                    Rectangle()
                        .stroke(Color.white.opacity(0.16), lineWidth: 1)
                )
                .frame(height: 140)

            HStack(spacing: 12) {
                Button(action: onBack) {
                    Image("Back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 23, height: 23)
                        .frame(width: 40, height: 58)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(String(localized: "accessibility.back"))

                HStack(spacing: 16) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.white.opacity(0.5))
                        .accessibilityHidden(true)

                    TextField(nameType, text: $query)
                        .font(.appleSDGothicNeo(.bold, size: 20))
                        .foregroundStyle(.white)
                        .tint(.white)
                        .submitLabel(.search)
                        .accessibilityLabel(String(localized: "accessibility.search"))

                    if !query.isEmpty {
                        Button {
                            query = ""
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.white.opacity(0.75))
                                .frame(width: 26, height: 26)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel(String(localized: "accessibility.close.menu"))
                    }
                }
                .padding(.horizontal, 19)
                .frame(height: 58)
                .background(
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color.white.opacity(0.1))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color.white.opacity(0.14), lineWidth: 1)
                )
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 19)
        }
        .ignoresSafeArea(edges: .top)
    }
}

private struct SearchResultRow: View {
    let result: PokemonSearchResult
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(result.name)
                        .font(.appleSDGothicNeo(.bold, size: 20))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)

                    Text(result.englishName)
                        .font(.appleSDGothicNeo(.regular, size: 12))
                        .foregroundStyle(.white.opacity(0.45))
                        .lineLimit(1)
                }

                Spacer()

                HStack(spacing: 4) {
                    ForEach(Array(result.types.prefix(2).enumerated()), id: \.offset) { _, type in
                        TypeSmallToken(type: type)
                    }
                    if result.types.count == 1 {
                        TypeSmallToken(type: .noType)
                    }
                }
            }
            .frame(height: 58)
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(result.name)
        .accessibilityValue(result.types.map(\.label).joined(separator: ", "))
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel(), onBack: {}, onSelect: { _ in })
}
