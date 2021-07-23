//
//  Place.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 23.07.2021.
//

import MapKit

class Place: NSObject, MKAnnotation {
    let meteoriteName: String
    let locationName: String
    let coordinate: CLLocationCoordinate2D

    var title: String? {
        return meteoriteName
    }

    var subtitle: String? {
        return locationName
    }

    init(
        meteoriteName: String,
        locationName: String,
        coordinate: CLLocationCoordinate2D
    ) {
        self.meteoriteName = meteoriteName
        self.locationName = locationName
        self.coordinate = coordinate

        super.init()
    }
}
