//
//  MeteoritesListViewModel.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 22.07.2021.
//

import UIKit
import CoreLocation
import RxSwift

protocol MeteoritesListViewModelDelegate: AnyObject {
    func refreshData()
    func dataDidReload()
    func saveData(_ meteorites: [Meteorite], completition: @escaping (() -> Void))
    func setUpData(completition: @escaping (([Meteorite]) -> Void))
}

final class MeteoritesListViewModel {
    // -MR- Comment: Remove prototype data
//    private var meteorites = [Meteorite]()

    weak var delegate: MeteoritesListViewModelDelegate?

    private var meteoriteRequester: MeteoriteRequester
    private var disposeBag = DisposeBag()

    var meteorites = [Meteorite]()

    init() {
        meteoriteRequester = MeteoriteRequester()
    }

    private func process(meteorites: [Meteorite]) {

        self.meteorites = meteorites
            .sorted { $0.size.value > $1.size.value }

            delegate?.refreshData()
        
// -MR- Comment: delete
//        self.meteorites.forEach { meteorite in
//            print(meteorite.size.value)
//        }
    }

    func loadMeteorites() {
        meteoriteRequester.getMeteorites()
            .subscribe(
                onSuccess: { [weak self] meteorites in
                    guard let self = self else { return }
                    self.process(meteorites: meteorites)
                    self.delegate?.saveData(self.meteorites) { [weak self] in
                        self?.delegate?.dataDidReload()
                    }
                },
                onFailure: { error in
                    // -MR- Comment: dodelat implementaci erroru
                    debugPrint(error.localizedDescription)
                }
            ).disposed(by: disposeBag)
    }

    func setUpMeteorites() {
        delegate?.setUpData { [weak self] in
            self?.process(meteorites: $0)
        }
    }

    func setUpCell(cell: UITableViewCell, for index: Int) -> UITableViewCell {
        if let item = meteorites[safe: index] {
            cell.textLabel?.text = item.name
            cell.imageView?.image = UIImage(named: "seal.fill")
            cell.imageView?.tintColor = item.size.level.color
        }
        return cell
    }
}

// -MR- Comment: remove
//        let meteor1 = Meteorite(name: "Dormamu", size: .big, location: CLLocationCoordinate2D(latitude: 16.60, longitude: 49.195))
//        let meteor2 = Meteorite(name: "Merdok", size: .small, location: CLLocationCoordinate2D(latitude: 16.60, longitude: 49.195))
//        let meteor3 = Meteorite(name: "Gingle", size: .medium, location: CLLocationCoordinate2D(latitude: 21.282778, longitude: -157.829444))
//        self.meteorites = [meteor1, meteor2, meteor3]
