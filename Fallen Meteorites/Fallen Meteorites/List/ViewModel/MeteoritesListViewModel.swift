//
//  MeteoritesListViewModel.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 22.07.2021.
//

import CoreLocation

final class MeteoritesListViewModel {
    // -MR- Comment: Remove prototype data
//    private var meteorites = [Meteorite]()
    var meteorites = [Meteorite]()

    init() {
        let meteor1 = Meteorite(name: "Dormamu", size: .big, location: CLLocationCoordinate2D(latitude: 16.60, longitude: 49.195))
        self.meteorites.append(meteor1)
    }

}
