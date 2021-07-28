//
//  MeteoritesListViewController.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 21.07.2021.
//

import UIKit

class MeteoritesListViewController: UITableViewController {

    private let userSettingsProvider: UserSettingsProvider
    private let databaseService: DatabaseService

    private var viewModel: MeteoritesListViewModel
    private var selectedMeteorite: Meteorite?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataIfNeeded()
    }

    required init?(coder: NSCoder) {
        viewModel = MeteoritesListViewModel()
        userSettingsProvider = UserSettingsProvider.shared
        databaseService = DatabaseService()

        super.init(coder: coder)

        viewModel.delegate = self
    }

    private func loadDataIfNeeded() {
        userSettingsProvider.needsToReloadData ? viewModel.loadMeteorites() : viewModel.setUpMeteorites()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let identifier = segue.identifier,
            let meteorite = selectedMeteorite
        else { return }

        if
            identifier == Constants.SegueIdentifiers.goToMap.rawValue,
            let mapViewController = segue.destination as? MapViewController
        {
            mapViewController.meteorite = meteorite
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.meteorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "MeteoritesListIemCell")
        return viewModel.setUpCell(cell: cell, for: indexPath.row)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMeteorite = viewModel.meteorites[safe: indexPath.row]
        performSegue(withIdentifier: "goToMap", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MeteoritesListViewController: MeteoritesListViewModelDelegate {
    func errorOccured(_ error: Error) {
        guard let localizedError = error as? LocalizedError else {
            presentAlert(title: error.localizedDescription)
            return
        }
        presentAlert(title: localizedError.errorDescription ?? "")
    }

    func dataDidReload() {
        userSettingsProvider.dataDidReload()
    }

    func setUpData(completition: @escaping (([Meteorite]) -> Void)) {
        databaseService.loadMeteorites(completition: completition)
    }
    
    func saveData(_ meteorites: [Meteorite], completition: @escaping (() -> Void)) {
        databaseService.saveMeteorites(meteorites, completition: completition)
    }

    func refreshData() {
        tableView.reloadData()
    }
}
