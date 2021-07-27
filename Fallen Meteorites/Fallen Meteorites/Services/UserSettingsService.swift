//
//  UserSettingsService.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 27.07.2021.
//

import Foundation

public final class UserSettingsService {

    private enum Keys: String {
        case lastReloadOfData
    }

    private let userDefaults: UserDefaults

    var lastReloadOfData: Date? {
        get {
            userDefaults.value(forKey: Keys.lastReloadOfData.rawValue) as? Date
        }
        set {
            userDefaults.setValue(newValue, forKey: Keys.lastReloadOfData.rawValue)
        }
    }

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
}
