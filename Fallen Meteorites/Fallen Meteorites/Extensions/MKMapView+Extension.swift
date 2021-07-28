//
//  MKMapView+Extension.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 23.07.2021.
//

import MapKit

extension MKMapView {
    func centerToCoordinate(
        _ coordinate: CLLocationCoordinate2D,
        regionRadius: CLLocationDistance = 1000000
    ) {
        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        setRegion(region, animated: true)
    }
}
