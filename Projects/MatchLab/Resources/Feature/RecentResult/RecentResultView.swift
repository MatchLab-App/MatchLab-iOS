//
//  RecentResultView.swift
//  MatchLab
//
//  Created by Codex on 5/13/26.
//

import SwiftUI

struct RecentResultView: View {
    @ObservedObject var viewModel: RecentResultViewModel
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
                        title: L10n.currentRecords,
                        showsLogo: false,
                        leftIconName: "Back",
                        leftAccessibilityLabel: String(localized: "accessibility.back"),
                        onLeftTap: onBack
                    )
                    .padding(.bottom, 9)
                }
                .ignoresSafeArea(edges: .top)

                VStack(alignment: .leading, spacing: 18) {
                    Text(L10n.currentRecords)
                        .font(.appleSDGothicNeo(.semiBold, size: 15))
                        .foregroundStyle(.white.opacity(0.75))
                        .padding(.leading, 20)

                    RecentRecordsList(records: viewModel.recentRecords)
                }
                .padding(.horizontal, 30)
                .padding(.top, 16)

                Spacer(minLength: 0)
            }
        }
        .onAppear {
            viewModel.loadRecentRecords()
        }
    }
}

private struct RecentRecordsList: View {
    let records: [RecentMatchRecord]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if records.isEmpty {
                RoundedRectangle(cornerRadius: 17)
                    .fill(Color.white.opacity(0.1))
                    .overlay(
                        Text("-")
                            .font(.appleSDGothicNeo(.semiBold, size: 15))
                            .foregroundStyle(.white.opacity(0.6))
                    )
                    .frame(height: 72)
            } else {
                ForEach(Array(records.prefix(5).enumerated()), id: \.offset) { _, record in
                    RecentRecordRow(record: record)
                }
                ForEach(Array(records.prefix(5).enumerated()), id: \.offset) { _, record in
                    RecentRecordRow(record: record)
                }
                ForEach(Array(records.prefix(5).enumerated()), id: \.offset) { _, record in
                    RecentRecordRow(record: record)
                }
                ForEach(Array(records.prefix(5).enumerated()), id: \.offset) { _, record in
                    RecentRecordRow(record: record)
                }
                ForEach(Array(records.prefix(5).enumerated()), id: \.offset) { _, record in
                    RecentRecordRow(record: record)
                }
            }
        }
    }
}

private struct RecentRecordRow: View {
    let record: RecentMatchRecord

    private var displayTypes: [PokemonType] {
        let source = record.defenseTypes + [record.attackType]
        let trimmed = Array(source.prefix(3))
        return trimmed + Array(repeating: .noType, count: max(0, 3 - trimmed.count))
    }

    private var multiplierTextColor: Color {
        record.multiplier == 0 ? Color(red: 1.0, green: 0.15, blue: 0.38) : Color(red: 0.25, green: 0.92, blue: 0.85)
    }

    var body: some View {
        HStack(spacing: 10) {
            HStack(spacing: 8) {
                ForEach(Array(displayTypes.enumerated()), id: \.offset) { _, type in
                    TypeSmallToken(type: type)
                        .frame(width: 40, height: 54)
                }
            }

            Rectangle()
                .fill(Color.white.opacity(0.2))
                .frame(width: 1, height: 36)

            Text("\(formatMultiplier(record.multiplier))X")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundStyle(multiplierTextColor)
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 12)
        .frame(height: 72)
        .background(
            RoundedRectangle(cornerRadius: 17)
                .fill(Color.white.opacity(0.1))
        )
    }

    private func formatMultiplier(_ value: Double) -> String {
        let asInt = Int(value)
        if Double(asInt) == value {
            return String(asInt)
        }
        if value == 0.25 {
            return "0.25"
        }
        if value == 0.5 {
            return "0.5"
        }
        return String(value)
    }
}

#Preview {
    RecentResultView(viewModel: RecentResultViewModel(), onBack: {})
}
