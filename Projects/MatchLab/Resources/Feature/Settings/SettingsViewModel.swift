//
//  SettingsViewModel.swift
//  MatchLab
//
//  Created by Codex on 5/12/26.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var selectedLanguage = L10n.korean
    @Published var isFileAccessEnabled = true
}
