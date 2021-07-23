//
//  Meteorite.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 22.07.2021.
//

import CoreLocation
import UIKit

enum Level: Int {
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

extension Level {
    static func resolve(from size: Int) -> Level {
        let level = size / 1000
        return Level(rawValue: level) ?? Level.big
    }
}

struct Size {
    let value: Int
    let level: Level

    init(value: Int) {
        self.value = value
        self.level = Level.resolve(from: value)
    }
}

struct Meteorite {
    let name: String
    let size: Size
    let location: CLLocationCoordinate2D
}

extension Meteorite: Decodable {

    private enum CodingKeys: String, CodingKey {
        case name, mass, geolocation
    }

    private enum LocationContainer: String, CodingKey {
        case latitude, longitude
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // -MR- Comment: lat long z geo

        name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Unknown"

        let massString = try container.decodeIfPresent(String.self, forKey: .mass) ?? "0"
        let mass = Int(massString) ?? 0

        size = Size(value: mass)

        let locationContainer = try container.nestedContainer(keyedBy: LocationContainer.self, forKey: .geolocation)

        let lat = try locationContainer.decodeIfPresent(String.self, forKey: .latitude) ?? "0.0"
        let latitude = Double(lat) ?? 0.0
        let long = try locationContainer.decodeIfPresent(String.self, forKey: .longitude) ?? "0.0"
        let longitude = Double(long) ?? 0.0
//        let lat = coordinates?.first ?? 0.0
//        let long = coordinates?.last ?? 0.0

        location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
