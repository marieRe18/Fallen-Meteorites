//
//  MeteoritesListViewController.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 21.07.2021.
//

import UIKit

class MeteoritesListViewController: UITableViewController {

    private var viewModel: MeteoritesListViewModel
    private var selectedMeteorite: Meteorite?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    required init?(coder: NSCoder) {
        viewModel = MeteoritesListViewModel()
        super.init(coder: coder)
        viewModel.delegate = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.meteorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "MeteoritesListIemCell")
        return viewModel.setUpCell(cell: cell, for: indexPath.row)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let identifier = segue.identifier,
            let meteorite = selectedMeteorite
        else { return }

        if
            identifier == segueIdentifiers.goToMap.rawValue,
            let mapViewController = segue.destination as? MapViewController
        {
            mapViewController.meteorite = meteorite
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMeteorite = viewModel.meteorites[safe: indexPath.row]
        performSegue(withIdentifier: "goToMap", sender: self)
    }
}

extension MeteoritesListViewController: MeteoritesListViewModelDelegate {
    func refreshData() {
        tableView.reloadData()
    }
}

enum segueIdentifiers: String {
    case goToMap
}
