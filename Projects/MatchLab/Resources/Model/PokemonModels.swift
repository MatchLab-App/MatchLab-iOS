//
//  PokemonModels.swift
//  MatchLab
//
//  Created by Codex on 5/12/26.
//

import Foundation

struct PokemonNameEntry: Decodable {
    let englishName: String
    let japaneseName: String
    let types: [PokemonType]

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case japaneseName = "japanese_name"
        case types
    }
}

struct PokemonSearchResult: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let englishName: String
    let japaneseName: String
    let types: [PokemonType]
}

struct PokemonTypeChartEntry: Decodable {
    let attack: [String: Double]
}

final class PokemonDataStore {
    static let shared = PokemonDataStore()

    private let names: [String: PokemonNameEntry]
    private let typeCharts: [String: PokemonTypeChartEntry]

    private init() {
        names = Self.loadJSON(named: "PokemonNames") ?? [:]
        typeCharts = Self.loadJSON(named: "PokemonTypeCharts") ?? [:]
    }

    func searchPokemon(query: String) -> [PokemonSearchResult] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return [] }

        return names
            .filter { name, entry in
                name.localizedCaseInsensitiveContains(trimmed)
                || entry.englishName.localizedCaseInsensitiveContains(trimmed)
                || entry.japaneseName.localizedCaseInsensitiveContains(trimmed)
            }
            .sorted {
                let lhsStartsWithQuery = $0.key.hasPrefix(trimmed)
                let rhsStartsWithQuery = $1.key.hasPrefix(trimmed)
                if lhsStartsWithQuery != rhsStartsWithQuery {
                    return lhsStartsWithQuery
                }
                return $0.key < $1.key
            }
            .map { name, entry in
                PokemonSearchResult(
                    name: name,
                    englishName: entry.englishName,
                    japaneseName: entry.japaneseName,
                    types: entry.types
                )
            }
    }

    func multiplier(attackType: PokemonType, defenseTypes: [PokemonType]) -> Double {
        guard attackType != .noType else { return 1.0 }

        return defenseTypes
            .filter { $0 != .noType }
            .reduce(1.0) { result, defenseType in
                let typeChart = typeCharts[attackType.rawValue]
                return result * (typeChart?.attack[defenseType.rawValue] ?? 1.0)
            }
    }

    private static func loadJSON<T: Decodable>(named name: String) -> T? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }
}
