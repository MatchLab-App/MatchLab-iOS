//
//  AppRootViewModel.swift
//  MatchLab
//
//  Created by Codex on 5/12/26.
//

import Foundation

enum MatchLabRoute {
    case start
    case notice
    case home
    case search
    case settings
}

final class AppRootViewModel: ObservableObject {
    @Published var route: MatchLabRoute = .start

    let homeViewModel = HomeViewModel()
    let searchViewModel = SearchViewModel()
    let settingsViewModel = SettingsViewModel()

    func start() {
        route = .notice
    }

    func confirmNotice() {
        route = .home
    }

    func showHome() {
        route = .home
    }

    func showSearch() {
        route = .search
    }

    func selectSearchResult(_ result: PokemonSearchResult) {
        homeViewModel.addDefenseTypes(result.types)
        route = .home
    }

    func showSettings() {
        route = .settings
    }
}
