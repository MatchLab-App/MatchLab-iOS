//
//  HomeViewModel.swift
//  MatchLab
//
//  Created by Codex on 5/12/26.
//

import Foundation
import SwiftUI

struct RecentMatchRecord: Codable {
    let defenseTypes: [PokemonType]
    let attackType: PokemonType
    let multiplier: Double
    let createdAt: Date
}

enum HomeStep {
    case selectFirstOpponentType
    case selectSecondOpponentType
    case selectAttackType
    case result
}

struct EffectivenessSummary {
    let multiplier: Double

    var title: String {
        switch multiplier {
        case 0: return L10n.noEffectiveness
        case 0.25: return L10n.superWeakEffectiveness
        case 0.5: return L10n.weakEffectiveness
        case 2: return L10n.strongEffectiveness
        case 4: return L10n.superStrongEffectiveness
        default: return L10n.normalEffectiveness
        }
    }

    var description: String {
        switch multiplier {
        case 0: return L10n.noEffectivenessDescription
        case 0.25, 0.5: return L10n.weakEffectivenessDescription
        case 2, 4: return L10n.strongEffectivenessDescription
        default: return L10n.normalEffectivenessDescription
        }
    }

    var tint: Color {
        switch multiplier {
        case 0, 0.25, 0.5: return Color(red: 1.0, green: 0.15, blue: 0.38)
        default: return Color(red: 0.08, green: 0.96, blue: 0.87)
        }
    }
}

final class HomeViewModel: ObservableObject {
    private enum StorageKey {
        static let recentRecords = "matchlab.recent.records"
    }

    private let maxRecentRecordCount = 50

    @Published var step: HomeStep = .selectFirstOpponentType
    @Published var selectedDefenseTypes: [PokemonType] = []
    @Published var selectedAttackType: PokemonType = .noType
    @Published var isMenuPresented = false

    var primaryDefenseType: PokemonType {
        selectedDefenseTypes.first ?? .noType
    }

    var secondaryDefenseType: PokemonType {
        selectedDefenseTypes.dropFirst().first ?? .noType
    }

    var effectivenessSummary: EffectivenessSummary {
        let multiplier = PokemonDataStore.shared.multiplier(
            attackType: selectedAttackType,
            defenseTypes: selectedDefenseTypes
        )
        return EffectivenessSummary(multiplier: multiplier)
    }

    var title: String {
        switch step {
        case .selectFirstOpponentType, .selectSecondOpponentType:
            return L10n.opponentType
        case .selectAttackType:
            return L10n.attackType
        case .result:
            return effectivenessSummary.title
        }
    }

    var subtitle: String {
        switch step {
        case .selectFirstOpponentType, .selectSecondOpponentType:
            return L10n.opponentTypeDescription
        case .selectAttackType:
            return L10n.attackTypeDescription
        case .result:
            return effectivenessSummary.description
        }
    }

    var prompt: String {
        switch step {
        case .selectFirstOpponentType:
            return L10n.oppopentTypeSelect
        case .selectSecondOpponentType:
            return L10n.opponentTypeSelect2
        case .selectAttackType, .result:
            return L10n.attacktypeSelect
        }
    }

    var actionTitle: String {
        switch step {
        case .selectSecondOpponentType:
            return L10n.goNext
        case .selectAttackType, .result:
            return L10n.goFirst
        case .selectFirstOpponentType:
            return L10n.goNext
        }
    }

    var actionEnabled: Bool {
        switch step {
        case .selectFirstOpponentType:
            return false
        default:
            return true
        }
    }

    func select(_ type: PokemonType) {
        switch step {
        case .selectFirstOpponentType:
            selectedDefenseTypes = [type]
            step = .selectSecondOpponentType
        case .selectSecondOpponentType:
            if selectedDefenseTypes.contains(type) {
                selectedDefenseTypes.removeAll { $0 == type }
            } else if selectedDefenseTypes.count < 2 {
                selectedDefenseTypes.append(type)
            } else {
                selectedDefenseTypes[1] = type
            }
            if selectedDefenseTypes.isEmpty {
                step = .selectFirstOpponentType
            }
        case .selectAttackType, .result:
            selectedAttackType = type
            step = .result
            saveRecentRecord()
        }
    }

    func addDefenseTypes(_ types: [PokemonType]) {
        for type in types where type != .noType {
            if selectedDefenseTypes.contains(type) {
                continue
            }

            if selectedDefenseTypes.count < 2 {
                selectedDefenseTypes.append(type)
            } else {
                selectedDefenseTypes[1] = type
            }
        }

        if selectedDefenseTypes.isEmpty {
            step = .selectFirstOpponentType
        } else {
            step = .selectSecondOpponentType
        }
    }

    func performPrimaryAction() {
        switch step {
        case .selectFirstOpponentType:
            break
        case .selectSecondOpponentType:
            step = .selectAttackType
        case .selectAttackType, .result:
            reset()
        }
    }

    func goBack() {
        if isMenuPresented {
            isMenuPresented = false
            return
        }

        switch step {
        case .selectFirstOpponentType:
            break
        case .selectSecondOpponentType:
            selectedDefenseTypes.removeAll()
            step = .selectFirstOpponentType
        case .selectAttackType:
            selectedAttackType = .noType
            step = .selectSecondOpponentType
        case .result:
            selectedAttackType = .noType
            step = .selectAttackType
        }
    }

    func editDefenseSelection() {
        selectedAttackType = .noType
        if selectedDefenseTypes.isEmpty {
            step = .selectFirstOpponentType
        } else {
            step = .selectSecondOpponentType
        }
    }

    func reset() {
        selectedDefenseTypes.removeAll()
        selectedAttackType = .noType
        step = .selectFirstOpponentType
        isMenuPresented = false
    }

    private func saveRecentRecord() {
        let defense = selectedDefenseTypes.filter { $0 != .noType }
        guard !defense.isEmpty, selectedAttackType != .noType else { return }

        let record = RecentMatchRecord(
            defenseTypes: defense,
            attackType: selectedAttackType,
            multiplier: effectivenessSummary.multiplier,
            createdAt: Date()
        )

        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        let defaults = UserDefaults.standard

        var records: [RecentMatchRecord] = []
        if let savedData = defaults.data(forKey: StorageKey.recentRecords),
           let decoded = try? decoder.decode([RecentMatchRecord].self, from: savedData) {
            records = decoded
        }

        records.insert(record, at: 0)
        if records.count > maxRecentRecordCount {
            records = Array(records.prefix(maxRecentRecordCount))
        }

        if let encoded = try? encoder.encode(records) {
            defaults.set(encoded, forKey: StorageKey.recentRecords)
        }
    }
}
