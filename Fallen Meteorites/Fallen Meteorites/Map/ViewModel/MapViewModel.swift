//
//  MapViewModel.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 23.07.2021.
//

final class MapViewModel {
    var meteorite: Meteorite? {
        didSet {
            guard let safeMeteorite = meteorite else { return }

            meteoritesPlace = Place(
                meteoriteName: safeMeteorite.name,
                locationName: "Tady",
                coordinate: safeMeteorite.location
            )
        }
    }
    var meteoritesPlace: Place?
}
