//
//  AppRootView.swift
//  MatchLab
//
//  Created by Codex on 5/12/26.
//

import SwiftUI

struct AppRootView: View {
    @StateObject private var viewModel = AppRootViewModel()

    var body: some View {
        Group {
            switch viewModel.route {
            case .start:
                StartView {
                    viewModel.start()
                }
            case .notice:
                NoticeView(
                    onBack: { viewModel.route = .start },
                    onConfirm: { viewModel.confirmNotice() }
                )
            case .home:
                HomeView(
                    viewModel: viewModel.homeViewModel,
                    onSearch: { viewModel.showSearch() },
                    onSettings: { viewModel.showSettings() },
                    onRecentResults: { viewModel.showRecentResults() }
                )
            case .search:
                SearchView(
                    viewModel: viewModel.searchViewModel,
                    onBack: { viewModel.showHome() },
                    onSelect: { result in
                        viewModel.selectSearchResult(result)
                    }
                )
            case .settings:
                SettingsView(
                    viewModel: viewModel.settingsViewModel,
                    onBack: { viewModel.showHome() }
                )
            case .recentResults:
                RecentResultView(
                    viewModel: viewModel.recentResultViewModel,
                    onBack: { viewModel.showHome() }
                )
            }
        }
    }
}

#Preview {
    AppRootView()
}
