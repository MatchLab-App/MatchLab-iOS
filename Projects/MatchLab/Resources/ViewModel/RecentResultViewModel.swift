//
//  RecentResultViewModel.swift
//  MatchLab
//
//  Created by Codex on 5/13/26.
//

import Foundation

final class RecentResultViewModel: ObservableObject {
    private enum StorageKey {
        static let recentRecords = "matchlab.recent.records"
    }

    @Published var recentRecords: [RecentMatchRecord] = []

    func loadRecentRecords() {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()

        guard let data = defaults.data(forKey: StorageKey.recentRecords),
              let decoded = try? decoder.decode([RecentMatchRecord].self, from: data) else {
            recentRecords = []
            return
        }

        recentRecords = decoded
    }
}
