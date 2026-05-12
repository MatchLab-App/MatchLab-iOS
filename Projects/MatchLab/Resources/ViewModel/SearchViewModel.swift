//
//  SearchViewModel.swift
//  MatchLab
//
//  Created by Codex on 5/12/26.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published var query: String = "리자" {
        didSet {
            results = PokemonDataStore.shared.searchPokemon(query: query)
        }
    }
    @Published private(set) var results: [PokemonSearchResult] = []

    init() {
        results = PokemonDataStore.shared.searchPokemon(query: query)
    }
}
