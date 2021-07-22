//
//  Meteorite.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 22.07.2021.
//

import CoreLocation

enum Size: Int {
    case unknown
    case small
    case medium
    case big
}

struct Meteorite {
    let name: String
    let size: Size
    let location: CLLocationCoordinate2D
}
