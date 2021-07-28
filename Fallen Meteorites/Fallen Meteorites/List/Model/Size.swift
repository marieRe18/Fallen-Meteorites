//
//  Size.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 23.07.2021.
//

import UIKit

struct Size {
    let value: Int
    let level: Level

    init(value: Int) {
        self.value = value
        self.level = Level.resolve(from: value)
    }
}

enum Level: Int {
    case unknown
    case small
    case medium
    case big

    var multiplier: CGFloat {
        get {
            switch self {
            case .unknown:
                return 1
            case .small:
                return 1.2
            case .medium:
                return 1.4
            case .big:
                return 1.6
            }
        }
    }
    // -MR- Comment: delete?
//    var color: UIColor {
//        get {
//            switch self {
//            case .unknown:
//                return Constants.Colors.standardGray
//            case .small:
//                return UIColor.yellow
//            case .medium:
//                return UIColor.orange
//            case .big:
//                return UIColor.red
//            }
//        }
//    }
}

extension Level {
    static func resolve(from size: Int) -> Level {
        let level = size / 1000
        return Level(rawValue: level) ?? Level.big
    }
}
