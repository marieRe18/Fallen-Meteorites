//
//  UserSettingsProvider.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 27.07.2021.
//

import Foundation

public final class UserSettingsProvider {
    private let userSettingsService: UserSettingsService

    var needsToReloadData: Bool {
        guard let lastLaunch = userSettingsService.lastReloadOfData else { return true }

        let now = Date()
        let diffInDays = Calendar.current.dateComponents([.day], from: lastLaunch, to: now).day ?? 0

        return diffInDays > 0
    }

    public static let shared = UserSettingsProvider(userSettingsService: UserSettingsService(userDefaults: UserDefaults.standard))

    private init(userSettingsService: UserSettingsService) {
        self.userSettingsService = userSettingsService
    }

    public func dataDidReload() {
        userSettingsService.lastReloadOfData = Date()
    }
}
