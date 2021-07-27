//
//  UserSettingsService.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 27.07.2021.
//

import Foundation

public final class UserSettingsService {

    private enum Keys: String {
        case lastLaunch
    }

    let userDefaults: UserDefaults

    var lastLaunch: Date? {
        get {
            userDefaults.value(forKey: Keys.lastLaunch.rawValue) as? Date
        }
        set {
            userDefaults.setValue(newValue, forKey: Keys.lastLaunch.rawValue)
        }
    }

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
}
