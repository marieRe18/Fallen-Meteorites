//
//  MeteoritesListViewModel.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 22.07.2021.
//

import UIKit
import CoreLocation

final class MeteoritesListViewModel {
    // -MR- Comment: Remove prototype data
//    private var meteorites = [Meteorite]()
    var meteorites = [Meteorite]()
    private var meteoriteRequester: MeteoriteRequester

    init() {
        meteoriteRequester = MeteoriteRequester()
        setUpMeteorites()
        let meteor1 = Meteorite(name: "Dormamu", size: .big, location: CLLocationCoordinate2D(latitude: 16.60, longitude: 49.195))
        let meteor2 = Meteorite(name: "Merdok", size: .small, location: CLLocationCoordinate2D(latitude: 16.60, longitude: 49.195))
        let meteor3 = Meteorite(name: "Gingle", size: .medium, location: CLLocationCoordinate2D(latitude: 21.282778, longitude: -157.829444))
        self.meteorites = [meteor1, meteor2, meteor3]
    }

    private func setUpMeteorites() {
        meteoriteRequester.getMeteorites()
    }

    func setUpCell(cell: UITableViewCell, for index: Int) -> UITableViewCell {
        if let item = meteorites[safe: index] {
            cell.textLabel?.text = item.name
            cell.imageView?.image = UIImage(named: "seal.fill")
            cell.imageView?.tintColor = item.size.color
        }
        return cell
    }

}
