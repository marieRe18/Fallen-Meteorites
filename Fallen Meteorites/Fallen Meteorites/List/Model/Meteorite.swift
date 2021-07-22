//
//  Meteorite.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 22.07.2021.
//

import CoreLocation
import UIKit

enum Size: Int {
    case unknown
    case small
    case medium
    case big

    var color: UIColor {
        get {
            switch self {
            case .unknown:
                return UIColor.white
            case .small:
                return UIColor.yellow
            case .medium:
                return UIColor.orange
            case .big:
                return UIColor.red
            }
        }
    }
}

struct Meteorite {
    let name: String
    let size: Size
    let location: CLLocationCoordinate2D
}
