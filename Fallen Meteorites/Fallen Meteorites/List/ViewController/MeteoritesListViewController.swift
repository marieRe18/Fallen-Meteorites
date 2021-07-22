//
//  MeteoritesListViewController.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 21.07.2021.
//

import UIKit

class MeteoritesListViewController: UITableViewController {

    private var viewModel: MeteoritesListViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    required init?(coder: NSCoder) {
        self.viewModel = MeteoritesListViewModel()
        super.init(coder: coder)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.meteorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "MeteoritesListIemCell")
        return viewModel.setUpCell(cell: cell, for: indexPath.row)
    }
}
