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
    func errorOccured(_ error: Error)
}

final class MeteoritesListViewModel {
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
                onFailure: { [weak self] error in
                    self?.delegate?.errorOccured(error)
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
            let itemSizeLevel = item.size.level.rawValue

            cell.textLabel?.text = item.name
            cell.imageView?.image = Constants.MeteoriteImage.init(rawValue: itemSizeLevel)?.img
            cell.backgroundColor = Constants.Colors.darkBlue
            cell.textLabel?.textColor = Constants.Colors.standardWhite
        }
        return cell
    }
}
